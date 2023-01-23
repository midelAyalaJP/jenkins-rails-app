require 'rails_helper'

RSpec.describe "Categores", type: :request do
    #let!(:auth_headers) { {'Authorization' => "Bearer #{user.auth_token}"} }
    # let!(:user) {create(:user)};
    # let!(:auth_headers) { {'Authorization' => "Bearer #{user.auth_token}"} }

   

    #post "/users/sign_in", params: credentials

    # payload = (headers["Authorization"]);
   

    # let!(:auth_headers) { {'Authorization' => "Bearer #{payload}"} }

    #LOGIN
    before(:all) do
        user = User.create(name: "aaa", email: "aa@ok.com", password:"123456");
        credentials = { user: {"email" => user.email, "password" => user.password}  }
        post "/users/sign_in", params: credentials
        payload = (headers["Authorization"]);
        # payload = JSON.parse(response.body);
        @headers = {'Authorization' => "#{payload}"};
      
        #print "BEFORE\n"
    end



    
       
       

    describe "GET /categories" do
        
        
        it "INDEX should return status ok" do

            get "/categories", headers: @headers


            payload = JSON.parse(response.body);
            expect(payload).to be_empty;
            expect(response).to have_http_status(:ok);
        end

        describe "With data" do
            let!(:categories) { create_list(:category, 10)}

        
            it "INDEX" do
                get '/categories', headers: @headers

                
                payload = JSON.parse(response.body);


                expect(payload.size).to eq(categories.size);
                expect(payload[0]).to_not be_empty;
                expect(payload[0]["id"]).to eq(categories[0].id);
                expect(payload[0]["spanish_description"]).to eq(categories[0].spanish_description);
                expect(payload[0]["english_description"]).to eq(categories[0].english_description);
            
                expect(response).to have_http_status(200);
            end
        end
        
    end



    
    describe "GET /categories/{id}" do
        let!(:category) { create(:category)}


        it "SHOW" do
            get "/categories/#{category.id}", headers: @headers;
            payload = JSON.parse(response.body);
            expect(payload).to_not be_empty;
            expect(payload["id"]).to eq(category.id);
            expect(payload["spanish_description"]).to eq(category.spanish_description);
            expect(payload["english_description"]).to eq(category.english_description);
           
            expect(response).to have_http_status(200);
        end

        it "SHOW not found" do
            get "/categories/9999", headers: @headers;
            payload = JSON.parse(response.body);
            expect(payload).to_not be_empty;
            expect(payload["error"]).to_not be_empty;
            
            expect(response).to have_http_status(:not_found);
        end
    end


    describe "POST /categories" do
        
        it "STORE" do
            req_payload = {
                category:{
                    spanish_description: "spanish",
                    english_description: "english"
                }
            }

            post "/categories", params: req_payload, headers: @headers
            payload = JSON.parse(response.body);
            
            expect(payload).to_not be_empty;
            expect(payload["id"]).to_not be_nil;
            expect(payload["spanish_description"]).to eq(req_payload[:category][:spanish_description]);
            expect(payload["english_description"]).to eq(req_payload[:category][:english_description]);
           
            expect(response).to have_http_status(:created);
        end
    end


    describe "PUT /categories/{id}" do
        let!(:category) { create(:category)}

        it "UPDATE" do
            req_payload = {
                category:{
                    spanish_description: "edited value",
                    english_description: "edited value"
                }
            }

            put "/categories/#{category.id}", params: req_payload, headers: @headers

            get "/categories/#{category.id}", headers: @headers;
            payload = JSON.parse(response.body);
            
            expect(payload).to_not be_empty;
            expect(payload["id"]).to_not be_nil;
            expect(payload["spanish_description"]).to eq(req_payload[:category][:spanish_description]);
            expect(payload["english_description"]).to eq(req_payload[:category][:english_description]);
           
            expect(response).to have_http_status(:ok);
        end
    end



    describe "DELETE /categories/{id}" do
        let!(:category) { create(:category)}

        it "DELETE" do
            delete "/categories/#{category.id}", headers: @headers;

            payload = JSON.parse(response.body);
            expect(response).to have_http_status(:ok);


            get "/categories/#{category.id}", headers: @headers;
            expect(response).to have_http_status(:not_found);
        end

    end
   


end
