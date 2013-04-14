node.deploy[:certificates].each do |name,keys|
  file "/etc/ssl/certs/#{name}.crt" do
    content keys[:crt]
  end if keys[:crt]
  file "/etc/ssl/private/#{name}.key" do
    content keys[:key]
  end if keys[:key]
end if node.deploy[:certificates]
