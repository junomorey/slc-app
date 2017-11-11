class Tutee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :tutor
  has_and_belongs_to_many :time_availabilitys, as: :time_availabilityable 
  has_one :study_session
  
  def assign_tutor_and_session
    if self.tutor.nil?
      matched_tutor, available_tutors = nil, []
      available_tutors = find_available_tutors
      if !available_tutors.empty?
        matched_tutor = get_best_tutor(available_tutors)
        assign_session(matched_tutor)
      end
      matched_tutor
    else
      self.tutor
    end
  end
  
  private
  
  def assign_session(matched_tutor)
    matched_times = matched_tutor.time_availabilitys & self.time_availabilitys
    booked_time_availability = matched_times[0]
    my_study_session = self.study_session
    my_study_session.time_availability = booked_time_availability
    my_study_session.tutor = matched_tutor
    my_study_session.tutee = self
    my_study_session.save!
    self.time_availabilitys.delete(booked_time_availability) 
    self.save!
    matched_tutor.time_availabilitys.delete(booked_time_availability) # Remove availability since study session booked
    matched_tutor.study_sessions << my_study_session
    matched_tutor.save!
  end
  
  def get_best_tutor(available_tutors_list)
    available_tutors_list = available_tutors_list.sort_by{|tutor| tutor.tutees.length}
    best_tutor = available_tutors_list[0]
    self.tutor =  best_tutor # Assigning tutor with least existing tutees
    self.save!
    best_tutor.tutees << self
    best_tutor.save!
    best_tutor
  end
  
  def find_available_tutors
    available_tutors_list = []
    Tutor.all.each do |tutor|
      matched_times = tutor.time_availabilitys & self.time_availabilitys # Intersection
      if !matched_times.empty?
        available_tutors_list << tutor
      end
    end
    available_tutors_list
  end
  
end
