class Comedian < ActiveRecord::Base
  has_many :specials
  validates_presence_of :firstname
  validates_presence_of :age

  def self.fetch_data(params)
    result = {}
    if params[:age] && params[:age] != "any"
      comedians = Comedian.where(age: params[:age])
      result[:comedians] = comedians
      result[:cities] = comedians.distinct.pluck(:city)
      result[:average_age] = comedians.average(:age)
    else
      result[:comedians] = Comedian.all
      result[:cities] = Comedian.cities
      result[:average_age] = Comedian.average_age
    end

    case params[:sort]
    when "age"
      result[:comedians] = result[:comedians].order(age: :asc)
    when "name"
      result[:comedians] = result[:comedians].order(firstname: :asc)
    when "city"
      result[:comedians] = result[:comedians].order(city: :asc)
    end
    result
  end

  def image_path
    folder_name = name.downcase.gsub(' ', '_')
    "images/comedians/#{folder_name}/profile_pic.jpg"
  end
  def name
    return firstname unless lastname
    firstname + ' ' + lastname
  end
  def self.average_age
    average(:age)
  end
  def self.cities
    distinct.pluck(:city)
  end
end
