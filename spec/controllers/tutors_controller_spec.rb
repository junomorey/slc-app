require 'rails_helper'

RSpec.describe TutorsController, type: :controller do
    
     describe "routes / to correct home path", :type => :routing do
        it 'routes to update route' do
            expect(get("/")).to route_to("pages#home")
        end
    end
    
    describe "tutee_path(@tutee) works for show", :type => :routing do
        it 'routes to show route' do
            expect(get("/tutors/1")).to route_to("tutors#show", :id => '1')
        end
    end
    
    describe "tutee_path(@tutee) works for update", :type => :routing do
        it 'routes to update route' do
            expect(patch("/tutors/1")).to route_to("tutors#update", :id => '1')
        end
    end
    
    describe "routes /tutors/1/edit to correct path", :type => :routing do
        it 'routes to edit route' do
            expect(get("tutors/1/edit/")).to route_to("tutors#edit", :id => "1")
        end
    end
    
    describe "routes /tutors/1/tutee_match to correct path", :type => :routing do
        it 'routes to tutee_match route' do
            expect(get("tutors/1/tutee_match/")).to route_to("tutors#tutee_match", :id => "1")
        end
    end
    
    describe 'fill in attributes' do
        it 'should have a filled in first and last name attribute' do
            tutor = instance_double("Tutor", :email => "apple@gmail.com", :password => "example", :password_confirmation => "example", :first_name => "Sally", :last_name => "Sue")
            expect(tutor).to have_attributes(:email => "apple@gmail.com", :password => "example", :password_confirmation => "example", :first_name => "Sally", :last_name => "Sue")
        end
    end
    
    
    describe 'invalid params should throw an error' do
        it 'should throw an ArgumentError with no first name' do
            invalid_hash = {
               first_name: nil
            }
            expect{put :update, id: 1, tutor: invalid_hash}.to raise_error(ArgumentError)
        end
    end

    describe 'invalid params throwing an error' do
        it 'should throw an ArgumentError with no last name' do
            invalid_hash = {
               first_name: "C",
               last_name: nil
            }
            expect{put :update, id: 1, tutor: invalid_hash}.to raise_error(ArgumentError)
        end
    end
    
    describe 'update should redirect' do

        it 'redirect to the show view' do
            tutor = Tutor.create(:email => "email@c.com", :password => "password")
            put :update, :id => tutor.id, :tutor => { :first_name => "C", :last_name => "V" }
            tutor.reload
            expect(tutor.first_name).to eq("C")
            expect(tutor.last_name).to eq("V")
        end
    end
    
    describe 'test tutee match function' do
        it 'should say there are no available tutors' do
            tutor = Tutor.create(:email => "email@c.com", :password => "password")
            put :update, :id => tutor.id, :tutor => { :first_name => "C", :last_name => "V" }
            tutor.reload
            put :tutee_match, :id => tutor.id
            #response.should have_text("Your time availabilities do not match with any tutor. Please revise your preferences & try again.")
            expect(tutor.tutees).to eq([])
        end
    end
    
    describe "Tutor is sent an email" do
        xit "it is not implementd" do
            pending("method not implemented") do
                email = UserMailer.create_invite('SLC@example.com',
                                     'tutor1@gmail.com', Time.now)
                assert_emails 1 do
                    email.deliver_now
                end
                assert_equal ['SLC@example.com'], email.from
                assert_equal ['tutor1@gmail.com'], email.to
                assert_equal 'This is a test', email.subject
                # for pending purposes only
                true.should be(true)
            end
        end
    end
end
