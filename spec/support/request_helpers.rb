class ActionDispatch::TestResponse
  def json
    @json ||= JSON.parse(body).with_indifferent_access
  end
end
