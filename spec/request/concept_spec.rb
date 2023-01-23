require 'rails_helper'

RSpec.describe "Concepts", type: :request do

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



    describe "GET /concepts" do
        
        
        it "INDEX should return status ok" do

            get "/concepts", headers: @headers


            payload = JSON.parse(response.body);
            expect(payload).to be_empty;
            expect(response).to have_http_status(:ok);
        end

        describe "With data" do
            let!(:concepts) { create_list(:concept, 10)}

        
            it "INDEX" do
                get '/concepts', headers: @headers

                
                payload = JSON.parse(response.body);
               
                expect(payload.size).to eq(concepts.size);
                expect(payload[0]).to_not be_empty;
                expect(payload[0]["id"]).to eq(concepts[0].id);
                expect(payload[0]["spanish_description"]).to eq(concepts[0].spanish_description);
                expect(payload[0]["english_description"]).to eq(concepts[0].english_description);
                
                expect(response).to have_http_status(200);
            end
        end
        
    end



    describe "GET /concepts/{id}" do
        let!(:concept) { create(:concept)}


        it "SHOW" do
            get "/concepts/#{concept.id}", headers: @headers;
            payload = JSON.parse(response.body);
            expect(payload).to_not be_empty;
            expect(payload["id"]).to eq(concept.id);
            expect(payload["spanish_description"]).to eq(concept.spanish_description);
            expect(payload["english_description"]).to eq(concept.english_description);
            expect(payload["category"]["id"]).to eq(concept.category.id);
            expect(payload["category"]["spanish_description"]).to eq(concept.category.spanish_description);
            expect(payload["category"]["english_description"]).to eq(concept.category.english_description);
           
            expect(response).to have_http_status(200);
        end

        it "SHOW not found" do
            get "/concepts/9999", headers: @headers;
            payload = JSON.parse(response.body);
            expect(payload).to_not be_empty;
            expect(payload["error"]).to_not be_empty;
            
            expect(response).to have_http_status(:not_found);
        end
    end


    describe "POST /concepts" do
        let!(:category) { create(:category)}


        it "STORE" do
            req_payload = {
                concept:{
                    spanish_description: "spanish",
                    english_description: "english",
                    category_id: category.id
                }
            }

            post "/concepts", params: req_payload, headers: @headers
            payload = JSON.parse(response.body);
            
            expect(payload).to_not be_empty;
            expect(payload["id"]).to_not be_nil;
            expect(payload["spanish_description"]).to eq(req_payload[:concept][:spanish_description]);
            expect(payload["english_description"]).to eq(req_payload[:concept][:english_description]);
            expect(payload["english_description"]).to eq(req_payload[:concept][:english_description]);
           
            expect(response).to have_http_status(:created);
        end
    end
end