# ...
class SendVerifySmsWorker
  include Sidekiq::Worker

  def perform(sms_code_id)
    record = VerifySmsMessage.find(sms_code_id)
    record.update!(sent_at: Time.now)
  end
end
