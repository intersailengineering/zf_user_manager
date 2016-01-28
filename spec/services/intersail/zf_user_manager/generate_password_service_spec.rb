require 'spec_helper'

module Intersail
  module ZfUserManager
    class FakeHTTPartyResponse
      def initialize(data, code)
        @data = data
        @code = code
      end

      def [](value)
        @data["value"]
      end

      def code
        @code
      end
    end

    describe GeneratePasswordService do
      describe '#call' do
        let(:user_id) { 1 }
        let(:success_res) { FakeHTTPartyResponse.new({id: user_id, username: "username", email: "fake@mail.com", password: "new_pwd"},200) }
        subject { GeneratePasswordService.new(user_id, double(), "app_name", "http://login_url") }

        it 'asks zf_client.user to reset_password of the user_id' do
          zf_client = double("zf_client")
          user_manager = double("user_manager")
          expect(zf_client).to receive(:user).and_return(user_manager)
          expect(user_manager).to receive(:reset_password).with(user_id).and_return(success_res)
          subject.zf_client = zf_client
          subject.call
        end

        describe 'email sending' do
          before do
            @zf_client = double("zf_client")
            expect(@zf_client).to receive_message_chain(:user, :reset_password).and_return(FakeHTTPartyResponse.new({},code))
            subject.zf_client = @zf_client
          end
          context 'response code 200' do
            let(:code) {200}
            it 'asks reset_password mailer to send the reset_password_mail' do
              expect(::ZfUserManager::ResetPassword).to receive_message_chain(:reset_password, :deliver_later)
              subject.call
            end
          end

          context 'response code != 200' do
            let(:code) {400}
            it "doesn't ask reset_password mailer to send the email" do
              expect(::ZfUserManager::ResetPassword).to_not receive(:reset_password)
              subject.call
            end
          end
        end
      end
    end
  end
end