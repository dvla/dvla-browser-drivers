module DVLA
  module Browser
    module Drivers
      # Borrowed from https://github.com/puppeteer/puppeteer/blob/main/packages/puppeteer-core/src/common/Device.ts
      MOBILE_PROFILES = {
        blackberry_playbook: {
          user_agent: 'Mozilla/5.0 (PlayBook; U; RIM Tablet OS 2.1.0; en-US) AppleWebKit/536.2+ (KHTML like Gecko) Version/7.2.1.0 Safari/536.2+',
          width: 600, height: 1024, device_scale_factor: 1, mobile: true, has_touch: true
        },
        blackberry_playbook_landscape: {
          user_agent: 'Mozilla/5.0 (PlayBook; U; RIM Tablet OS 2.1.0; en-US) AppleWebKit/536.2+ (KHTML like Gecko) Version/7.2.1.0 Safari/536.2+',
          width: 1024, height: 600, device_scale_factor: 1, mobile: true, has_touch: true
        },
        blackberry_z30: {
          user_agent: 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.10+ (KHTML, like Gecko) Version/10.0.9.2372 Mobile Safari/537.10+',
          width: 360, height: 640, device_scale_factor: 2, mobile: true, has_touch: true
        },
        blackberry_z30_landscape: {
          user_agent: 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.10+ (KHTML, like Gecko) Version/10.0.9.2372 Mobile Safari/537.10+',
          width: 640, height: 360, device_scale_factor: 2, mobile: true, has_touch: true
        },
        galaxy_note_3: {
          user_agent: 'Mozilla/5.0 (Linux; U; Android 4.3; en-us; SM-N900T Build/JSS15J) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30',
          width: 360, height: 640, device_scale_factor: 3, mobile: true, has_touch: true
        },
        galaxy_note_3_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; U; Android 4.3; en-us; SM-N900T Build/JSS15J) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30',
          width: 640, height: 360, device_scale_factor: 3, mobile: true, has_touch: true
        },
        galaxy_note_ii: {
          user_agent: 'Mozilla/5.0 (Linux; U; Android 4.1; en-us; GT-N7100 Build/JRO03C) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30',
          width: 360, height: 640, device_scale_factor: 2, mobile: true, has_touch: true
        },
        galaxy_note_ii_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; U; Android 4.1; en-us; GT-N7100 Build/JRO03C) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30',
          width: 640, height: 360, device_scale_factor: 2, mobile: true, has_touch: true
        },
        galaxy_s_iii: {
          user_agent: 'Mozilla/5.0 (Linux; U; Android 4.0; en-us; GT-I9300 Build/IMM76D) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30',
          width: 360, height: 640, device_scale_factor: 2, mobile: true, has_touch: true
        },
        galaxy_s_iii_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; U; Android 4.0; en-us; GT-I9300 Build/IMM76D) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30',
          width: 640, height: 360, device_scale_factor: 2, mobile: true, has_touch: true
        },
        galaxy_s5: {
          user_agent: 'Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 360, height: 640, device_scale_factor: 3, mobile: true, has_touch: true
        },
        galaxy_s5_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 640, height: 360, device_scale_factor: 3, mobile: true, has_touch: true
        },
        galaxy_s8: {
          user_agent: 'Mozilla/5.0 (Linux; Android 7.0; SM-G950U Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.84 Mobile Safari/537.36',
          width: 360, height: 740, device_scale_factor: 3, mobile: true, has_touch: true
        },
        galaxy_s8_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 7.0; SM-G950U Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.84 Mobile Safari/537.36',
          width: 740, height: 360, device_scale_factor: 3, mobile: true, has_touch: true
        },
        galaxy_s9_plus: {
          user_agent: 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G965U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.111 Mobile Safari/537.36',
          width: 320, height: 658, device_scale_factor: 4.5, mobile: true, has_touch: true
        },
        galaxy_s9_plus_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 8.0.0; SM-G965U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.111 Mobile Safari/537.36',
          width: 658, height: 320, device_scale_factor: 4.5, mobile: true, has_touch: true
        },
        galaxy_tab_s4: {
          user_agent: 'Mozilla/5.0 (Linux; Android 8.1.0; SM-T837A) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.0 Safari/537.36',
          width: 712, height: 1138, device_scale_factor: 2.25, mobile: true, has_touch: true
        },
        galaxy_tab_s4_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 8.1.0; SM-T837A) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.0 Safari/537.36',
          width: 1138, height: 712, device_scale_factor: 2.25, mobile: true, has_touch: true
        },
        ipad: {
          user_agent: 'Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1',
          width: 768, height: 1024, device_scale_factor: 2, mobile: true, has_touch: true
        },
        ipad_landscape: {
          user_agent: 'Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1',
          width: 1024, height: 768, device_scale_factor: 2, mobile: true, has_touch: true
        },
        ipad_gen_6: {
          user_agent: 'Mozilla/5.0 (iPad; CPU OS 12_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Mobile/15E148 Safari/604.1',
          width: 768, height: 1024, device_scale_factor: 2, mobile: true, has_touch: true
        },
        ipad_gen_6_landscape: {
          user_agent: 'Mozilla/5.0 (iPad; CPU OS 12_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Mobile/15E148 Safari/604.1',
          width: 1024, height: 768, device_scale_factor: 2, mobile: true, has_touch: true
        },
        ipad_gen_7: {
          user_agent: 'Mozilla/5.0 (iPad; CPU OS 13_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0 Mobile/15E148 Safari/604.1',
          width: 810, height: 1080, device_scale_factor: 2, mobile: true, has_touch: true
        },
        ipad_gen_7_landscape: {
          user_agent: 'Mozilla/5.0 (iPad; CPU OS 13_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0 Mobile/15E148 Safari/604.1',
          width: 1080, height: 810, device_scale_factor: 2, mobile: true, has_touch: true
        },
        ipad_mini: {
          user_agent: 'Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1',
          width: 768, height: 1024, device_scale_factor: 2, mobile: true, has_touch: true
        },
        ipad_mini_landscape: {
          user_agent: 'Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1',
          width: 1024, height: 768, device_scale_factor: 2, mobile: true, has_touch: true
        },
        ipad_pro: {
          user_agent: 'Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1',
          width: 1024, height: 1366, device_scale_factor: 2, mobile: true, has_touch: true
        },
        ipad_pro_landscape: {
          user_agent: 'Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1',
          width: 1366, height: 1024, device_scale_factor: 2, mobile: true, has_touch: true
        },
        ipad_pro_11: {
          user_agent: 'Mozilla/5.0 (iPad; CPU OS 12_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Mobile/15E148 Safari/604.1',
          width: 834, height: 1194, device_scale_factor: 2, mobile: true, has_touch: true
        },
        ipad_pro_11_landscape: {
          user_agent: 'Mozilla/5.0 (iPad; CPU OS 12_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Mobile/15E148 Safari/604.1',
          width: 1194, height: 834, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_4: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 7_1_2 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D257 Safari/9537.53',
          width: 320, height: 480, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_4_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 7_1_2 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D257 Safari/9537.53',
          width: 480, height: 320, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_5: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1',
          width: 320, height: 568, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_5_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1',
          width: 568, height: 320, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_6: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
          width: 375, height: 667, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_6_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
          width: 667, height: 375, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_6_plus: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
          width: 414, height: 736, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_6_plus_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
          width: 736, height: 414, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_7: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
          width: 375, height: 667, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_7_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
          width: 667, height: 375, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_7_plus: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
          width: 414, height: 736, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_7_plus_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
          width: 736, height: 414, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_8: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
          width: 375, height: 667, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_8_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
          width: 667, height: 375, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_8_plus: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
          width: 414, height: 736, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_8_plus_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
          width: 736, height: 414, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_se: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1',
          width: 320, height: 568, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_se_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1',
          width: 568, height: 320, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_x: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
          width: 375, height: 812, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_x_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
          width: 812, height: 375, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_xr: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 12_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Mobile/15E148 Safari/604.1',
          width: 414, height: 896, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_xr_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 12_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Mobile/15E148 Safari/604.1',
          width: 896, height: 414, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_11: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Mobile/15E148 Safari/604.1',
          width: 414, height: 828, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_11_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Mobile/15E148 Safari/604.1',
          width: 828, height: 414, device_scale_factor: 2, mobile: true, has_touch: true
        },
        iphone_11_pro: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Mobile/15E148 Safari/604.1',
          width: 375, height: 812, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_11_pro_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Mobile/15E148 Safari/604.1',
          width: 812, height: 375, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_11_pro_max: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Mobile/15E148 Safari/604.1',
          width: 414, height: 896, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_11_pro_max_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Mobile/15E148 Safari/604.1',
          width: 896, height: 414, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_12: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 390, height: 844, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_12_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 844, height: 390, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_12_pro: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 390, height: 844, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_12_pro_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 844, height: 390, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_12_pro_max: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 428, height: 926, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_12_pro_max_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 926, height: 428, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_12_mini: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 375, height: 812, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_12_mini_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 812, height: 375, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_13: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 390, height: 844, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_13_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 844, height: 390, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_13_pro: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 390, height: 844, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_13_pro_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 844, height: 390, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_13_pro_max: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 428, height: 926, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_13_pro_max_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 926, height: 428, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_13_mini: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 375, height: 812, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_13_mini_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1',
          width: 812, height: 375, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_14: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1',
          width: 390, height: 663, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_14_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1',
          width: 750, height: 340, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_14_plus: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1',
          width: 428, height: 745, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_14_plus_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1',
          width: 832, height: 378, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_14_pro: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1',
          width: 393, height: 659, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_14_pro_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1',
          width: 734, height: 343, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_14_pro_max: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1',
          width: 430, height: 739, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_14_pro_max_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1',
          width: 814, height: 380, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_15: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1',
          width: 393, height: 659, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_15_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1',
          width: 734, height: 343, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_15_plus: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1',
          width: 430, height: 739, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_15_plus_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1',
          width: 814, height: 380, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_15_pro: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1',
          width: 393, height: 659, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_15_pro_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1',
          width: 734, height: 343, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_15_pro_max: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1',
          width: 430, height: 739, device_scale_factor: 3, mobile: true, has_touch: true
        },
        iphone_15_pro_max_landscape: {
          user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1',
          width: 814, height: 380, device_scale_factor: 3, mobile: true, has_touch: true
        },
        jiophone_2: {
          user_agent: 'Mozilla/5.0 (Mobile; LYF/F300B/LYF-F300B-001-01-15-130718-i;Android; rv:48.0) Gecko/48.0 Firefox/48.0 KAIOS/2.5',
          width: 240, height: 320, device_scale_factor: 1, mobile: true, has_touch: true
        },
        jiophone_2_landscape: {
          user_agent: 'Mozilla/5.0 (Mobile; LYF/F300B/LYF-F300B-001-01-15-130718-i;Android; rv:48.0) Gecko/48.0 Firefox/48.0 KAIOS/2.5',
          width: 320, height: 240, device_scale_factor: 1, mobile: true, has_touch: true
        },
        kindle_fire_hdx: {
          user_agent: 'Mozilla/5.0 (Linux; U; en-us; KFAPWI Build/JDQ39) AppleWebKit/535.19 (KHTML, like Gecko) Silk/3.13 Safari/535.19 Silk-Accelerated=true',
          width: 800, height: 1280, device_scale_factor: 2, mobile: true, has_touch: true
        },
        kindle_fire_hdx_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; U; en-us; KFAPWI Build/JDQ39) AppleWebKit/535.19 (KHTML, like Gecko) Silk/3.13 Safari/535.19 Silk-Accelerated=true',
          width: 1280, height: 800, device_scale_factor: 2, mobile: true, has_touch: true
        },
        lg_optimus_l70: {
          user_agent: 'Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; LGMS323 Build/KOT49I.MS32310c) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 384, height: 640, device_scale_factor: 1.25, mobile: true, has_touch: true
        },
        lg_optimus_l70_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; U; Android 4.4.2; en-us; LGMS323 Build/KOT49I.MS32310c) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 640, height: 384, device_scale_factor: 1.25, mobile: true, has_touch: true
        },
        microsoft_lumia_550: {
          user_agent: 'Mozilla/5.0 (Windows Phone 10.0; Android 4.2.1; Microsoft; Lumia 550) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Mobile Safari/537.36 Edge/14.14263',
          width: 640, height: 360, device_scale_factor: 2, mobile: true, has_touch: true
        },
        microsoft_lumia_950: {
          user_agent: 'Mozilla/5.0 (Windows Phone 10.0; Android 4.2.1; Microsoft; Lumia 950) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Mobile Safari/537.36 Edge/14.14263',
          width: 360, height: 640, device_scale_factor: 4, mobile: true, has_touch: true
        },
        microsoft_lumia_950_landscape: {
          user_agent: 'Mozilla/5.0 (Windows Phone 10.0; Android 4.2.1; Microsoft; Lumia 950) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Mobile Safari/537.36 Edge/14.14263',
          width: 640, height: 360, device_scale_factor: 4, mobile: true, has_touch: true
        },
        moto_g4: {
          user_agent: 'Mozilla/5.0 (Linux; Android 7.0; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4812.0 Mobile Safari/537.36',
          width: 360, height: 640, device_scale_factor: 3, mobile: true, has_touch: true
        },
        moto_g4_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 7.0; Moto G (4)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4812.0 Mobile Safari/537.36',
          width: 640, height: 360, device_scale_factor: 3, mobile: true, has_touch: true
        },
        nexus_10: {
          user_agent: 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 10 Build/MOB31T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Safari/537.36',
          width: 800, height: 1280, device_scale_factor: 2, mobile: true, has_touch: true
        },
        nexus_10_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 10 Build/MOB31T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Safari/537.36',
          width: 1280, height: 800, device_scale_factor: 2, mobile: true, has_touch: true
        },
        nexus_4: {
          user_agent: 'Mozilla/5.0 (Linux; Android 4.4.2; Nexus 4 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 384, height: 640, device_scale_factor: 2, mobile: true, has_touch: true
        },
        nexus_4_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 4.4.2; Nexus 4 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 640, height: 384, device_scale_factor: 2, mobile: true, has_touch: true
        },
        nexus_5: {
          user_agent: 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 360, height: 640, device_scale_factor: 3, mobile: true, has_touch: true
        },
        nexus_5_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 640, height: 360, device_scale_factor: 3, mobile: true, has_touch: true
        },
        nexus_5x: {
          user_agent: 'Mozilla/5.0 (Linux; Android 8.0.0; Nexus 5X Build/OPR4.170623.006) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 412, height: 732, device_scale_factor: 2.625, mobile: true, has_touch: true
        },
        nexus_5x_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 8.0.0; Nexus 5X Build/OPR4.170623.006) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 732, height: 412, device_scale_factor: 2.625, mobile: true, has_touch: true
        },
        nexus_6: {
          user_agent: 'Mozilla/5.0 (Linux; Android 7.1.1; Nexus 6 Build/N6F26U) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 412, height: 732, device_scale_factor: 3.5, mobile: true, has_touch: true
        },
        nexus_6_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 7.1.1; Nexus 6 Build/N6F26U) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 732, height: 412, device_scale_factor: 3.5, mobile: true, has_touch: true
        },
        nexus_6p: {
          user_agent: 'Mozilla/5.0 (Linux; Android 8.0.0; Nexus 6P Build/OPP3.170518.006) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 412, height: 732, device_scale_factor: 3.5, mobile: true, has_touch: true
        },
        nexus_6p_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 8.0.0; Nexus 6P Build/OPP3.170518.006) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 732, height: 412, device_scale_factor: 3.5, mobile: true, has_touch: true
        },
        nexus_7: {
          user_agent: 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 7 Build/MOB30X) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Safari/537.36',
          width: 600, height: 960, device_scale_factor: 2, mobile: true, has_touch: true
        },
        nexus_7_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 7 Build/MOB30X) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Safari/537.36',
          width: 960, height: 600, device_scale_factor: 2, mobile: true, has_touch: true
        },
        nokia_lumia_520: {
          user_agent: 'Mozilla/5.0 (compatible; MSIE 10.0; Windows Phone 8.0; Trident/6.0; IEMobile/10.0; ARM; Touch; NOKIA; Lumia 520)',
          width: 320, height: 533, device_scale_factor: 1.5, mobile: true, has_touch: true
        },
        nokia_lumia_520_landscape: {
          user_agent: 'Mozilla/5.0 (compatible; MSIE 10.0; Windows Phone 8.0; Trident/6.0; IEMobile/10.0; ARM; Touch; NOKIA; Lumia 520)',
          width: 533, height: 320, device_scale_factor: 1.5, mobile: true, has_touch: true
        },
        nokia_n9: {
          user_agent: 'Mozilla/5.0 (MeeGo; NokiaN9) AppleWebKit/534.13 (KHTML, like Gecko) NokiaBrowser/8.5.0 Mobile Safari/534.13',
          width: 480, height: 854, device_scale_factor: 1, mobile: true, has_touch: true
        },
        nokia_n9_landscape: {
          user_agent: 'Mozilla/5.0 (MeeGo; NokiaN9) AppleWebKit/534.13 (KHTML, like Gecko) NokiaBrowser/8.5.0 Mobile Safari/534.13',
          width: 854, height: 480, device_scale_factor: 1, mobile: true, has_touch: true
        },
        pixel_2: {
          user_agent: 'Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 411, height: 731, device_scale_factor: 2.625, mobile: true, has_touch: true
        },
        pixel_2_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 731, height: 411, device_scale_factor: 2.625, mobile: true, has_touch: true
        },
        pixel_2_xl: {
          user_agent: 'Mozilla/5.0 (Linux; Android 8.0.0; Pixel 2 XL Build/OPD1.170816.004) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 411, height: 823, device_scale_factor: 3.5, mobile: true, has_touch: true
        },
        pixel_2_xl_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 8.0.0; Pixel 2 XL Build/OPD1.170816.004) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3765.0 Mobile Safari/537.36',
          width: 823, height: 411, device_scale_factor: 3.5, mobile: true, has_touch: true
        },
        pixel_3: {
          user_agent: 'Mozilla/5.0 (Linux; Android 9; Pixel 3 Build/PQ1A.181105.017.A1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.158 Mobile Safari/537.36',
          width: 393, height: 786, device_scale_factor: 2.75, mobile: true, has_touch: true
        },
        pixel_3_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 9; Pixel 3 Build/PQ1A.181105.017.A1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.158 Mobile Safari/537.36',
          width: 786, height: 393, device_scale_factor: 2.75, mobile: true, has_touch: true
        },
        pixel_4: {
          user_agent: 'Mozilla/5.0 (Linux; Android 10; Pixel 4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Mobile Safari/537.36',
          width: 353, height: 745, device_scale_factor: 3, mobile: true, has_touch: true
        },
        pixel_4_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 10; Pixel 4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Mobile Safari/537.36',
          width: 745, height: 353, device_scale_factor: 3, mobile: true, has_touch: true
        },
        pixel_4a_5g: {
          user_agent: 'Mozilla/5.0 (Linux; Android 11; Pixel 4a (5G)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4812.0 Mobile Safari/537.36',
          width: 353, height: 745, device_scale_factor: 3, mobile: true, has_touch: true
        },
        pixel_4a_5g_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 11; Pixel 4a (5G)) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4812.0 Mobile Safari/537.36',
          width: 745, height: 353, device_scale_factor: 3, mobile: true, has_touch: true
        },
        pixel_5: {
          user_agent: 'Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4812.0 Mobile Safari/537.36',
          width: 393, height: 851, device_scale_factor: 3, mobile: true, has_touch: true
        },
        pixel_5_landscape: {
          user_agent: 'Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4812.0 Mobile Safari/537.36',
          width: 851, height: 393, device_scale_factor: 3, mobile: true, has_touch: true
        }
      }.freeze
    end
  end
end
