module PropertyRepresentationV20150120
  VERSION = '20150120'

  def as_json(options={})
    {
      id: id,
      name: name,
      province: province,
      heading: I18n.t('property_heading', province: province),
      location: Rails.application.routes.url_helpers.property_url(self, host: 'estate-dev.com:3000', version: VERSION),
      version: VERSION
    }
  end
end
