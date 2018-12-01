class Special < ActiveRecord::Base
  belongs_to :comedian
  validates_presence_of :title
  def self.average_runtime
    average(:runtime)
  end
  def self.fetch_data(params)
    result = {}
    if params[:age] && params[:age] != "any"
      comedians = Comedian.where(age: params[:age])
      specials = Special.where(comedian_id: comedians.pluck(:id))
      result[:average_runtime] = specials.empty? ? "N/A" : specials.map(&:runtime).sum / specials.size
      result[:total_specials] = specials.size
    else
      result[:average_runtime] = Special.average_runtime
      result[:total_specials] = Special.all.size
    end
    result
  end
end
