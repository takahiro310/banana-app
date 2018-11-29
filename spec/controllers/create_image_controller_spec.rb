require 'rails_helper'

RSpec.describe CreateImageController, type: :controller do

    describe "POST #exec" do

        before do
            Asfor.delete_all
            Asfor.create(question: 'AAA', answer: 'AAA', url_key: 'AAA', image: 'AAA')
        end

        context "question is blank" do 
            it "returns _ajax_error_partial" do
                post :exec, params: {asfor: {question: '', answer: 'AAA'}}
                expect(response).to render_template(partial: '_ajax_error_partial')
            end
        end
        context "question over 12char" do 
            it "returns _ajax_error_partial" do
                post :exec, params: {asfor: {question: '1234567890123', answer: 'AAA'}}
                expect(response).to render_template(partial: '_ajax_error_partial')
            end
        end
        context "question is blank" do
            it "returns _ajax_error_partial" do
                post :exec, params: {asfor: {question: '', answer: 'AAA'}}
                expect(response).to render_template(partial: '_ajax_error_partial')
            end
        end
        context "question over 12char" do
            it "returns _ajax_error_partial" do
                post :exec, params: {asfor: {question: '1234567890123', answer: 'AAA'}}
                expect(response).to render_template(partial: '_ajax_error_partial')
            end
        end
        context "answer is blank" do
            it "returns _ajax_error_partial" do
                post :exec, params: {asfor: {question: 'AAA', answer: ''}}
                expect(response).to render_template(partial: '_ajax_error_partial')
            end
        end
        context "answer over 12char" do
            it "returns _ajax_error_partial" do
                post :exec, params: {asfor: {question: 'AAA', answer: '1234567890123'}}
                expect(response).to render_template(partial: '_ajax_error_partial')
            end
        end
        context "exists asfor" do
            it "returns _ajax_partial" do
                post :exec, params: {asfor: {question: 'AAA', answer: 'AAA'}}
                expect(response).to render_template(partial: '_ajax_partial')
            end
        end
        context "not exists asfor" do
            it "returns _ajax_partial" do
                post :exec, params: {asfor: {question: 'BBB', answer: 'BBB'}}
                expect(response).to render_template(partial: '_ajax_partial')
            end
        end
    end

end
