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

    #@jtodoIMP extract below as login logic and go over with other test
    # the test for now will interact really with the external system
    # check the acceptancetest file and go from there

  end

end