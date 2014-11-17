require 'rails_helper'

describe CampaignsController, type: :controller do
  let!(:campaign) { FactoryGirl.create(:campaign_with_images)}


  describe "GET #index" do
    it "assigns the campaigns to @campaigns and renders the :index view" do
      get :index

      expect(assigns(:campaigns)).to eq(Campaign.all)
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    context 'Format HTML' do
      context 'empty params' do
        it "assigns the images to @images and renders the :show view" do
          get :show, id: campaign

          expect(assigns(:campaign)).to eq(campaign)
          expect(assigns(:names)).to eq(campaign.tags.pluck(:description, :name).uniq)
          expect(assigns(:values)).to eq(campaign.values_for_tag('title'))
          expect(assigns(:images)).to eq(campaign.images)
          expect(response).to render_template :show
        end
      end

      context 'with params' do
        it "assigns the images to @images and renders the :show view" do
          get :show, id: campaign, name: campaign.tags.first.name, tags: [campaign.tags.first.value]

          expect(assigns(:campaign)).to eq(campaign)
          expect(assigns(:names)).to eq(campaign.tags.pluck(:description, :name).uniq)
          expect(assigns(:values)).to eq(campaign.values_for_tag(campaign.tags.first.name))
          expect(assigns(:images)).to eq(campaign.search(campaign.tags.first.value))
          expect(response).to render_template :show
        end
      end
    end

    context 'Request XHR' do
      context 'empty params' do
        it "assigns the images to @images and renders 'images' partial" do
          xhr :get, :show, id: campaign

          expect(assigns(:campaign)).to eq(campaign)
          expect(assigns(:names)).to eq(campaign.tags.pluck(:description, :name).uniq)
          expect(assigns(:values)).to eq(campaign.values_for_tag('title'))
          expect(response).to render_template(partial: '_images')
        end
      end

      context 'with params' do
        it "assigns the images to @images and renders 'images' partial" do
          xhr :get, :show, id: campaign, name: campaign.tags.first.name, tags: [campaign.tags.first.value]

          expect(assigns(:campaign)).to eq(campaign)
          expect(assigns(:names)).to eq(campaign.tags.pluck(:description, :name).uniq)
          expect(assigns(:values)).to eq(campaign.values_for_tag(campaign.tags.first.name))
          expect(assigns(:images)).to eq(campaign.search(campaign.tags.first.value))
          expect(response).to render_template(partial: '_images')
        end
      end
    end
  end

  describe "GET #add_filter" do
    it "renders :filter partial" do
      xhr :get, :add_filter, id: campaign

      expect(assigns(:campaign)).to eq(campaign)
      expect(assigns(:names)).to eq(campaign.tags.pluck(:description, :name).uniq)
      expect(assigns(:values)).to eq(campaign.values_for_tag('title'))
      expect(response).to render_template(partial: '_filter')
    end
  end

  describe "GET #filter_values" do
    it "renders :select partial" do
      xhr :get, :filter_values, id: campaign, name: campaign.tags.first.name

      expect(assigns(:campaign)).to eq(campaign)
      expect(response).to render_template(partial: '_select')
    end
  end

  describe "GET #edit" do
    it "assigns the campaign to @campaign and renders the :edit view" do
      get :edit, id: campaign

      expect(assigns(:campaign)).to eq(campaign)
      expect(response).to render_template :edit
    end
  end

  describe "GET #new" do
    it "assigns the campaign to Campaign.new and renders the :new view" do
      get :new

      expect(assigns(:campaign)).to be_a_new(Campaign)
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    it "redirects to campaigns_path with flash notice message" do
      file = double(path: '/tmp/import.xlsx')
      expect_any_instance_of(Campaign).to receive(:import).with(file.path, '10').and_return true

      expect { post :create, campaign: { name: 'ABC' }, file: file.path, number_of_rows: 10 }.to change(Campaign, :count)
      expect(Campaign.last.name).to eq('ABC')

      expect(response).to redirect_to campaigns_path
    end
  end

  describe "PUT #update" do
    it "redirects to root path with flash notice message" do
      put :update, id: campaign, campaign: { name: 'XYZ' }

      expect(assigns(:campaign)).to eq(campaign)
      expect(Campaign.last.name).to eq('XYZ')
      expect(flash[:notice]).to eq 'Campaign was successfully updated.'
      expect(response).to redirect_to campaigns_path
    end
  end

  describe "DELETE #destroy" do
    it "redirects to root path with flash notice message" do
      expect { delete :destroy, id: campaign }.to change(Campaign, :count)
      expect(response).to redirect_to campaigns_path
    end
  end
end
