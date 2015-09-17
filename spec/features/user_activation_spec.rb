require 'spec_helper'

describe "user activation", type: :feature, js: true do
  it 'sends activation email' do
    visit '/'

    within("form#new_user") do
      fill_in 'inputUsername', :with => 'admin'
      fill_in 'inputPassword', :with => '123'
    end

    click_button 'Accedi'
    save_and_open_screenshot

    #@jtodoIMP make testing server for zaplofwsapi and use it for acceptance tests
    # the server allow you to push a given set of data so that you can do your acceptance test without
    # breaking anything

  end

end