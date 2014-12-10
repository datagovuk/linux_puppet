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
  host {'puppet':
    ip => '46.43.41.19'
  }
  host {'standards':
    ip => '46.43.41.17'
  }
  host {'dataconverter':
    ip => '46.43.41.16'
  }
  host {'dataservice':
    ip => '46.43.41.18'
  }
}

class dgu_users {
  beluga::user { 'noels':
    uid => 5001,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCuc0SV/j8yeDKINo8WOcaxrAbBxZuriZmT2OlXYEbZ3cWyzzevbI+nMcTc9UiivnFmFgTgV75qIlhv3p+dULF7Otu1fvGGFA0EY3ljeOPLqvF5hiqTmXDSvOEI3HQ0H5jiEWMmsFCSnVu5AaXuGKmHeotjQEczyYQmw0C7i8YV+HdnxlaN3A18SwzqfIClwuRDWogF3h3cQlHjXh4Kp68UOUB5LEX1XYP2/2l/dlXp+twJK7r/RI0JkLNLLDXaZjQpOkOVcuamcYemhbiDT4szVRz2SIkWAO/OwnGYOU0Zklv+7DJ1g1Gs8EQtr1l3LA6lv7Ah++kKUVKkUR8OkJlR',
    key_type => 'ssh-rsa',
  }

  beluga::user {'dread':
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

  beluga::user {'pete':
    uid => 5006,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDkKTI8g69iNTBnAM0BnCLZZY3wl1R0umyUDk58XD+7vfbxG0/1RyE1qo071jPwQoA21Meq+FFFB9mR6zQq3MFcu6dYL3D+xFaWmnVxu2y3MtXeJ4b/fShmF0DIe4ic6eQWSxY8Cjakz68+utJIioJeEtQ1PLsOqHlI9cMBlLp0JPo4JFLPv9B0TzMeGF6mQ3JXh9TS1M9TNXV/WyHz+9PyDjirnVRfQYDWanAvs+rw5uqID5lwW13cZBB4KJTu1kLWgpKRpto4gtDdmMhfKceMQAvTQpx+jiqvtPnmm/iIOXb1FxNpqWCNqZhpqgNUGvUkczIwmGu+xx5Nd0+p9EkT',
    key_type => 'ssh-rsa'
  }

  beluga::user {'thill':
    uid => 5007,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDzCjb8ti11Ydl/httnfvnXR6jEvSlsbln9WUmwTTzwBXcR36tYVbFeDL0iOiWcLIyV5LbBGjrS7WhYCwDZFMqHftxveiU2t7Ubaa1vl3uh7m+1+pXlsT6bTfO6z492APawOjRlPkcKsDIdBzv9w0EKyQwACTHeeRQ/eshrNFgdOrExH17tkZSuNE0YC8EzHB0efm1fKsRtMhYu7VqBZkCdSejALjpFzpik2ajtN1Kg9w2yajqfOHoizajE9OJpwmrjrIqDYr3edkuhvuUSvO6xfxHKwjo4BrXW/CvpfHopGPF5qqDOleV8vk/ioThZwYKE1a6s/576KDg4e/EWTrMp',
    key_type => 'ssh-rsa'
  }

  beluga::user {'nathan':
    uid => 5008,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQD62HaXWp+WxuU2INvtD+9jX8VuzgyL+mZ08GO1qDqDe6jX+HOz5CzZQ6s+oP0GUbaEP/CpCPuf5RHbLXaJoU4YgS8jR0f15G7IfI5Ez6aI5BZNj/AyQTlZbJlZCRyc+x5MnYcNcTM5pT0jQTJXhAlIjA+WgN4IcjmsJY5123JI9XYjz5nxstKwuH81agzZWOVT9u9gek1ySEer3s/K59O6GoZQfcNpwLum3EnUILxmFICayOohsEhpmL/FII+noJHsXipiwi3LGHQ1uleBOAQw/6YWwCfs+X/JggHxW7MY1Au3DF88zPhYNsB8nEG9BTrYEhS4llIe07kZRp11No1B',
    key_type => 'ssh-rsa'
  }

  beluga::user {'mattbee':
    uid => 5009,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDV85rbowKuJcogJaBXLEWO9MDKtFiNI23wN2v2ZdhKIaoyc6HYAjPb+XdQsLYmLlLWSlMFK7HM2qtpZ5EY0Qwvna+rpb2eOJgUT6dFVwkhaixcmaTpuGpnjwGx9iTBJZH7WNiYk41LyPJiuNcKblyE5+Vlmmo0JgnGT5osFrGT5aNSA0yRDGeXkxSkir+bfy03/AQrt9wq9umKQ5X/dckllD8Wen1HDf3dBQOpJerv/28NhUMFlJc2NfKfPMHJfq5bdhNtBW/WEBiutWayFbZIaWPLJTBlVhw3r6MqbqYPQOoRbKAdHb+FDyXDYTff6dnY5URTJ0RF8i3rtRg+y4Xv',
    key_type => 'ssh-rsa'
  }

  beluga::user {'prose':
    uid => 5010,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCuVcvATtQUdhiWggTfuwlqiELvAHR057ORXDPZzKPJRLrQiIfwqmyIukYoILCETRhQ74ODMdnhAmN8Tp0NeX/Zp7ZKnW2Rs+nnZ9eWEw3JT57v90PGGgjtVMfJVt7Re7z27zZtEB/F6yxAmxheGdVQ3O55n1jhP8r0PXbTiBVuDInTtCOkdtUDZYA1q16joR7ybuEE9cckNzp8EFb9zbspgBKnfPOvZyUmvTqZyvREENIdvbO9Ez68Zq6QEkydhQUTat3IXoBpi80jo40yxZFa2Ak4LvzHI9CMC1oshLZltCG2aFL7N4ycyTbjOQKNz0poBnrN8JxmgSDLzo67pRpd',
    key_type => 'ssh-rsa'
  }

  beluga::user {'jhackett':
    uid => 5011,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDKQds3dhX/09qcdugv7IvVurxi0bJQpWdJ/UsWs1f8oRWfw+atgxQ7BeShxfCs2MzkGGUp6khJ4Ucx1BPt7C03nklxvXGchKQKArL5Y3ECCU2B20rpOdWsNFU2IRBbVMOjz+a5+Lc2cjS+5qtR9/NDPlb2BFpebuno67FPw7l6rlhTfsiSDanTvbgyBE4X1STRQTaD0SHVCpb83K873GpZhhzPyJSSJKzYxA+Ppk9qNNdZr1sfI0oNUvuoDUzmWTPmem2I2zy4A/YguluzcgL0qLwg/YOvN6ALouIppWV3JkmzTv4ei+n5ZuE61yyV8fj8G3Z2HX1rsF56oRQ0sPzV',
    key_type => 'ssh-rsa'
  }

  beluga::user {'jhannah':
    uid => 5012,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDVRMbyKy2O/LtQzVEkIy2H+H2CRcV8dgFslIC3TruPWm0dr6X4O0s7NnJTB7A1y2Rcugk0xzgCTIkXMKzdgkr4d9ObJJhcDj+z9fCuEftaew5fdJx5kPUznaQHGXGAxRtaxVoHfhj50wD0Kw8Gi16u2EoWh4N16r0tIWLden7UJMfmnPD7zU3qPShj/XMKGYTjOPLvonGK5ow4eiQuK05+ghm1HtxcRtTohBHpAJ0NCdhhdbzp3SFSqqmuz7Otp1K6qNSse2tGx37+3vSYj89CQjfXD/HDzgnt+vU66LnDC1/ZyYH/GKKthsUmuEkXB2t0T2JyGnAJrUNiWZW7aNTL',
    key_type => 'ssh-rsa'
  }

  beluga::user {'jlawrie':
    uid => 5013,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCkVD/1NXrn5FvxwsUtfGBai8QsWAwJtce20aZOomCGCamN5O7U8ApcDmCt2RSo7T+GLQFPTi/rNq6kiH8JFmvtUMoti6kZkbopt52ibPzBhtM5WZMYH9qEXB07Uevd79/5lIEsydBUbeVVLRkuwQ4QybQApsOoghfITDU9HBOmo1aVEsEjTexs1RxzbZs9Is/W7tj0skyklHLGBXAdhQenDEdeFYKQYea3rkfB6UoOcKUebNk5asBWiVn3mDVE4T4rsBCZRa+qItdLIBJb/gm1s07eIGCL13Y+9Tnijn+YeGYniyqo9okBXxFM2Omxa2E92HtnFOPAT/lPRrN0Y0d5',
    key_type => 'ssh-rsa'
  }

  beluga::user {'telyn':
    uid => 5014,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCyEgFrVPKIlFUhkrXPDQkHS5jCCSmGJwF6JW18b4OE20E+MWtKXVNec8KSfrNmAv3uD06dyB/Bhk6tTRizcXJah2/e6xB0EhQJsVadPZker4qZn8yNvdKmn7aEmFmwgQ84pmGewbuuTRKmmV8VPFoZJwZjI3MaNTPdtm5HO9Fo2x05R9NTePbsYghvgMWosUTONraCbiX/XMUVnQVNoZPyWBlyp0GUQFkuoXN7SxFGxX4XEcReQZ3pgS+vWMkBITiRij0xIsqEQp/CLV0oUkvlbaB3sA5Br4k1UsRS4ZwdjR2LAxXSjHuowMz9rd0XOlXKIjUtx09adaUPYLafO9dp',
    key_type => 'ssh-rsa'
  }

  beluga::user {'pfoster':
    uid => 5015,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDAehQds8KnTD2skEyNfWqGDa9pZc0g1T2dDhqUPR6zZIYdVSem9pEDVd4P058BpBKDRtBJKZJtGbqIAMRBgQh5RoSPA5SUKpsf9ipersRlmqoItHtBB284kX5J4ABfr3fxCog7HfX3KYTsSuebyalyiL8rnIeRKgGgpBwGCRdHVt8CG6HLvg4yngMiojITMgLFb85iFbO7R5wWk1Gi/gPVqT1RVAh7zFtuGvmeXkDlap3Vx/3VJDQaja649BhoONGVYqubhDKfYCxw8+qV77y4KDLSuxUNGp6zezt8tFl1Vz5zFm9caudNLLuZOlY7ISnP8frWqq1wzSRSe3++gWAn',
    key_type => 'ssh-rsa'
  }

  beluga::user {'stevenraith':
    uid => 5016,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDLX6Ee+dKAaLuMTUC7VkgIPffeIRxsFO2vOOl0XMWT+pCIxw0bLR19GvvDCX5Nrw+WXN4GIcQB0hrYkokaQ+NyoTRILwiL3+5/9aAMneo5zWztiyfkHxt4Nlvk/d6cF0kleY7rHqmgG602OpSn5jpWZ7QkSccH1dw4zcF/qDjDNU/piBwIR0zryJGOIhMwCygdq++lX2PEGYOugSqXWyNDhzYT7Ogc2Fv2eEum76tX9xClmV1anBz6Bd70ZavnqbVqNfrkPlXvsKN1mzW9h3154uJK9tIx1WxugJcPKVEd5RrAwWB8Od0KyFpmvOo02QcIuBrWPI5OmO7UK2BfnC6L',
    key_type => 'ssh-rsa'
  }

  beluga::user {'patch':
    uid => 5017,
    groups => ['admins'],
    ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCivrFqnfd4ZYfxi6z0HGwzI3GytcTq+aIN0byc3zxSDedq1PXnP/i5e1c6Olkr/4fuJo1pcczNbDkkTK0NdYiEaG7eIKv0KSukxE85z1mZnjTHPLn2LjFkcT3W9+w7jZ62+LKVp8Yv5nqb6E3OILG9hwB/27Ai3kia+xu6Zjf4ptz5wM+fEp8rFnZ7Y9QcKALsOUdYuc5BZPBKXsHfpuHk/TuBKNnjEIfJ+2lnb5wcxTB57YhA9Qtv+jT9Q5wcX5zGdYao3AgFL50wt3C52U0lDVdVVAuCLQQ954LAOrEWDMHkHcqhE9bkHXEoFO/7w7aDQbw3Nq1EuzGL7kwLc251',
    key_type => 'ssh-rsa'
  }

  beluga::user {'djotto':
    uid     => 5018,
	groups  => ['admins'],
	ssh_key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCb0oQBfctaYbksZQnZp0MWIGtjJTd4o8tQGM3QJb39w31FiYFmXLo8XNLFnfZU1xr6WH2AeaaGtuPI5feemlzyDF58wHL1OSqETPQVqiSBiAz7WfiRl2Bdztu8yVvAEWWUJNDh9wncToa/dmBoMfq5K518iGoyO79NVU7FpzxCH9lSnL9bLHdC6bKXmuqUZ+lWRkTLVyUO9qt70GY58NohVJC15uUJ2tWA2TPl7PUMRvKL6TPjlosViQ8vBjFzWKO0+key8iWebz4Meu+xWJ9KDuH5ro4hSHOuIOduLARdw8DV6bnvTV4K9zC41dVIromNSj3Zwp0TQxOciC6/cg55',
	key_type => 'ssh-rsa',
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

class standards_site {

  mysql_user { ["standards@%"]:
    ensure => 'present',
    password_hash => mysql_password('standardspassword'),
  } ->

  mysql_grant { ["standards@%"]:
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => '*.*',
    user       => ["standards@%"],
  }
  mysql_database { 'standards':
      ensure  => 'present',
      charset => 'utf8',
  }
  file {['/var/www/private/', '/var/www/private/standards/','/var/www/files/', '/var/www/files/standards/', '/var/www/drupal/','/var/www/drupal/standards/']:
    ensure => 'directory',
    owner => 'co',
    group => 'www-data',
    mode => 775,
  }
  file {'/var/www/drupal/standards/logs':
    ensure => 'directory',
    owner => 'www-data',
    group => 'www-data',
  }
  apache::vhost { 'standards.data.gov.uk':
    override      => 'All',
    port          => 80,
    manage_docroot  => false,
    docroot       => '/var/www/drupal/standards/current',
    docroot_owner => 'co',
    docroot_group => 'co',
    serveradmin   => 'support@dguteam.org.uk',
    serveraliases => [
      'standards.dguteam.org.uk',
      'standards'],
    log_level     => 'warn',
    logroot => '/var/www/drupal/standards/logs',
  }
}
