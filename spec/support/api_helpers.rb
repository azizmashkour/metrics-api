module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def subject_json(subject)
    JSON.parse(subject.to_json)
  end
end