json.extract! property, :id, :name, :province, :width, :length
json.heading I18n.t('property_heading', province: property.province)
json.location api_property_url(property)
