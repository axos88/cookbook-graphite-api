packagecloud_repo 'exoscale/community' do
  type 'deb'
end

package 'graphite-api' do
  action :install
end

service 'graphite-api' do
  action :nothing
  supports start: true, stop: true, status: true, restart: true, reload: true
end

python_package 'graphite_influxdb' do
  action :install
end if node['graphite_api']['influxdb']['enabled']
