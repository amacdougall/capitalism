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
  haml :index, :locals => {page_title: "RepWard index"}
end

get "/rate/:doctor" do
  doctor = get_doctor_info params["doctor"]
  haml :rate, :locals => {
    :page_title => "Rate your visit",
    :doctor => doctor,
    :links => {
      :feedback_link => "/feedback/#{doctor['id']}",
      :publish_link =>  "/publish/#{doctor['id']}"
    }
  }
end

get "/feedback/:doctor" do
  doctor = get_doctor_info params["doctor"]
  haml :feedback, :locals => {:doctor => doctor}
end

get "/publish/:doctor" do
  doctor = get_doctor_info params["doctor"]
  haml :publish, :locals => {:doctor => doctor}
end
