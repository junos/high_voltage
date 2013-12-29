require 'spec_helper'

describe HighVoltage::PagesController, '#action_caching' do
  let(:page_name) { :exists }
  let(:page_cache_path) { 'views/test.host' + page_path(page_name) }

  context 'action_caching set to true' do
    it 'caches the action', enable_caching: true do
      HighVoltage.action_caching = true
      concern_reload

      get :show, id: page_name

      expect(cached_action?).to be_true
    end
  end

  context 'action_caching set to false' do
    it 'does not cache the action', enable_caching: true do
      HighVoltage.action_caching = false
      concern_reload

      get :show, id: page_name

      expect(cached_action?).to be_false
    end
  end

  def cached_action?
    ActionController::Base.cache_store.exist?(page_cache_path)
  end
end
