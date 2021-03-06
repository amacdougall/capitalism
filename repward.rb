require "sinatra"
require "haml"
require "safe_yaml"

helpers do
  # Gets doctor info from doctors.yml
  def get_doctor_info(id)
    info = YAML.load_file "data/doctors.yml"
    info[id]
  end
end

get "/" do
  haml :index, :locals => {:page_title => "RepWard index"}
end

# Rate a doctor
get "/:doctor" do
  doctor = get_doctor_info params["doctor"]
  haml :rate, :locals => {
    :page_title => "Rate your visit with #{doctor["name"]}",
    :doctor => doctor,
    :links => {
      :feedback_link => "/feedback/#{doctor['id']}",
      :publish_link =>  "/publish/#{doctor['id']}"
    }
  }
end

get "/:doctor/feedback" do
  doctor = get_doctor_info params["doctor"]
  feedback_link = "/feedback/#{doctor['id']}"
  haml :feedback, :locals => {
    :doctor => doctor,
    :feedback_link => feedback_link
  }
end

post "/:doctor/feedback" do
  # TODO: handle patient feedback by emailing the doctor
end

get "/:doctor/publish" do
  doctor = get_doctor_info params["doctor"]
  # TODO: add publish link from doctor profile
  haml :publish, :locals => {:doctor => doctor}
end
