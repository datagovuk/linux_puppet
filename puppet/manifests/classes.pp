class all_defaults{
  class { 'beluga':
    stage => pre,
  }
}
class dgu_defaults{
  class {'all_defaults': }
  class {'dgu_groups': } ->
  class {'dgu_users': } ->
  class {'dgu_keys': }
}

class prod_defaults {
  class {'dgu_defaults': }
  class {'sudo': }
}

class dgu_users {
  beluga::user { 'noels':
    uid => 5001,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCuc0SV/j8yeDKINo8WOcaxrAbBxZuriZmT2OlXYEbZ3cWyzzevbI+nMcTc9UiivnFmFgTgV75qIlhv3p+dULF7Otu1fvGGFA0EY3ljeOPLqvF5hiqTmXDSvOEI3HQ0H5jiEWMmsFCSnVu5AaXuGKmHeotjQEczyYQmw0C7i8YV+HdnxlaN3A18SwzqfIClwuRDWogF3h3cQlHjXh4Kp68UOUB5LEX1XYP2/2l/dlXp+twJK7r/RI0JkLNLLDXaZjQpOkOVcuamcYemhbiDT4szVRz2SIkWAO/OwnGYOU0Zklv+7DJ1g1Gs8EQtr1l3LA6lv7Ah++kKUVKkUR8OkJlR',
    key_type => 'ssh-rsa',
  }

  beluga::user {'davidr':
    uid => 5002,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1kc3MAAACBAOWojLyr0xJTKd/WWIGCP2Lkjkdt8nRUQXBVEBzeT8OJRXEF9grmqscdzHLedJoR/PyZNuLRT+1aD/fN7dF3nhdHYw/kseSFI1ZGss2btfxIEFGaWTmblu5yHOd+j8ws67aSQcixpyjOEwym07/l29n0Z2gqtiS01n0mj4R4VIBZAAAAFQCEcAW+SdTml9z97xtwOHd2pMiP8wAAAIEAzkoKP91JIYiwnCTRzO2M+9IT6FBvhUqoaZqTs6aeTJWvzFBoPPlt9T63V5Guke0DZcTW53QT7FE+NhoEt+FFAul09FhbjEhXVKbBYLMmx5/sQ54heRJEJqHYqEullJlG1mubxx29x/baiILLPp0JZf9eSpOjyVQf97YEKHmOphwAAACALTlUKABwoZbFEUNedLxib8F4NA+M2g6ynDADpJP3l2E9xqoBEZqeP2LoMci5c1ebTDeY9I7P6AQSYkoi9x/crcvb8aaTSUjCkEwli+QDNSDQo8b+x6HIvO+AvO0l5rR12QNiLckEJ7lP0+BLDidDdtqs1Izy8qEWU1KJi0AGxjY=',
    key_type => 'ssh-dss',
  }

  beluga::user {'pawelr':
    uid => 5003,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCaoQNpZVYtHCLKEJi5xfLhPoJiV0v5Xn5WEmAcbe43gbESWaCX4YeGGgwVboULq7M/P4agW8WMxIBZcl5/Pg6BRUY6uI7RX+zVcYt0U/Q4iTWB5777HA0v+gESYkPT0fn/5BK0QzQg5et0METTnH89tkpMfZbzVT6WRoQvnru9k5wAnjmHLJzU5qMl4gS5Jjy7JmNpr1xbJ/rD0U1IbV/DSQq0v2ytXyDv1yfyxqpVkA2IlOzg2Soa8oKtCTz1HMCqSdMytOKxAfWKlZO4daP4T9M2yNAio+Kzg+oa7tkc2HY6ViwNvvO/tcbJtLOkDxSoKZgOIAvi8w0WTqPVGs/x',
    key_type => 'ssh-rsa',
  }

  beluga::user::key {'pawel@pawel-pc':
    user => 'pawelr',
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqLEgQHDcG+e3c7CFC4hEpx8aorvSTJww132W7r8+ps5zAGfzh+zAY85jXMK9YC4G7gdA9EVX7ODzw/8W+63PbIHtquBVVyH+fEKkv70KC71ZRp52P0Ve1sMgihX7ErlVT3vw55Cd4x71NXXDTB+uAlynJDa4YYhWtkZkZ9Su/wVe+F4q3lmGmptuytCs4BzSWPiu+rUaWo18IXpPrx2EypkXiRrKTSem2BH+Zllw+EtXq7VUHKXzaPLHEshtAMTfxunPIs1QSwpOvc61Ntsw2154N+tbpDAyr0hUMeCsR2PdMEQTk+iU53JFbgl6mhGf1AMwsDpb5dxeCC3vkx4A7',
    key_type => 'ssh-rsa'
  }

  beluga::user {'tomr':
    uid => 5004,
    ssh_key => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAojip3xRT6Bbjr0HmPtbuugK4BhC/sGvzf0kIqBeNQyfXEGLM27R0U4pje2DE24x1DymbKRiTfxvMbkvYLozBACA0KK0HmyQbvqwDOkFra87KrlS0hgvoa/Eoip6XQtLjyoD59OWJAXc/VJn+LRVG+jIH5nAO23eUHTB+g7ItNtnA1QMsT8A2OVB4R9sbzkGwMg6qAaZRzJDHZQnkJb7x8S4koaRL0JLqF+Uqcbrhw3hBjuoS3e0VtgXRIEtO2dz7qRYJdKaVNr5heyUOOxmd+7DhVIAyrAlf2WePhR+PeB+qJ0fUMgcRZOtN1pHDh4/wSEo2IvPr3qCnfR9go5vrGw==',
    key_type => 'ssh-rsa'
  }

  beluga::user {'jasonb':
    uid => 5005,
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCoypusMcT0LZTfvyh7DLC/xTPsOnEYS3JOSwP4PFmN5QnwQGO250kkXDQ6UttxfimJbquvZY2MN3jQbwlTwQIY8xap81v13WjxMIHmN4dYd5GVrIGz6fw7uen3N25r53MIVPjL2UiD9D6RYLPYi9D4VifyjHNvd23lHzNIBAQUBQMMD3x15dStpMQpBgxZKmTkFGtvX1sbpXPHn9JIF4WsCQJshd0KE3NpfzMZIsbjP2NNjujHeKxzbgRjR1U2cP8BWGezBk+ZIbvkAFfzqEuedR5t2tQmCEDmSnc3T+JfRl0qoyZWr9y3rQqroaMF0MvgpdzfX4XfKY4UqczZcQzF',
    key_type => 'ssh-rsa'
  }
}

class dgu_keys {

  beluga::user::key {'jenkins_deployment':
    user => 'co',
    ssh_key => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAyd/uQuz+TAekzlXN0BJjxjdQhhjw/ilVZrjatVwZqBc92gR0vb4GqK3N1FIxKxnQ5ITFktiJuIV3t6FLtG6kjrZWpir0su4qQaAtk3OvZy4m0yDeYyBgUewRWJ8LkRKc1jE/V4KQWfUGFnp8FAkf3Z7WWuMsrmPbyXeKxhhXAWA+twMPG/eal7GYplA+7Vs5HMeqLsneOKlOIFORoE6c5Wro/jZtd+zZtjVOusZcL4ivlaj9SjjcAV71RjQdWR/WwAmewA9DE8QSKNwCbbC4t9Wt7MMyQAFnCS7fOBn54/Pmchc71wYr5s/2/z3m6CCTmamA5tA5nbIuPjZIiaT4cw==',
    key_type => 'ssh-rsa'
  }
}

class dgu_groups {
  group {
    "admins":
    ensure  => present,
    gid     => 7000;
  }
}

class epimorphics_users {
  beluga::user {'epimorphics':
    groups => ['admins'],
    uid => 6000,
  }
}

class epimorphics_keys {
  beluga::user::key {'dave@epimorphics.com':
    user => 'epimorphics',
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC42Ox+TLOfsTsb1kKybfj3WPOzrEjlfRnL8n1fl0218PLfSbpgaY7pUZZyoptfS5mpSTn3vzvmswib5nEY6wDM94PMdhZtjTIlfy6v84yoibq/Qn3PyVD72V7/lsKchuMElzLtFhPVptNu/OZ4vhkuj9k+z/PL2+RfqULUE+gQcomCYccGvdqu74/BX8QZqLkdygElksO7MSI4ohS//P73eCynqdI4cRAZf9V3CktQySesmYaFW3pdCgYhLq4XWMREcGlGw9aZ0W/uQYo9vw98MqCtThJPY/sW5ZgiTAOjtDRDXVIN45t96Zy5Y0Fbv677UOnZDdLVaoEdxIqlIuYv',
    key_type => 'ssh-rsa',
  }
}

class epimorphics_defaults {

  class { 'beluga::facts::role':
    stage => pre,
    role => 'epimorphics',
  } ->
  class {'prod_defaults': } ->
  class {'epimorphics_users': } ->
  class {'epimorphics_keys': }
}
