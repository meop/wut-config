$env.WUT_URL = 'http://arch.lan:9000'

def wut --wrapped [...args] {
  mut url = $"($env.WUT_URL)" | str trim --right --char '/'
  mut url = $"($url)/sh/nu"
  mut url = $"($url)/($args | str join '/')" | str trim --right --char '/'

  nu --no-config-file -c $"( http get --raw --redirect-mode follow $"($url)" )"
}
