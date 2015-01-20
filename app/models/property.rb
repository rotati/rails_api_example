class Property < ActiveRecord::Base
  VERSION = '20150116'
  validates :name, presence: true

  # Note that this is the models default implementation of the as_json method.
  # The client still needs to pass in the version number to see this representation.
  # The vversion number is specified as the class constant VERSION.

  def as_json(options={})
    {
      id: id,
      name: name,
      province: province,
      heading: I18n.t('property_heading', province: province),
      message: 'This is our default implementation of the as_json method. In version 20150120 this message will not appear! :)',
      version: VERSION
    }
  end
end
