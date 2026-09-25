# Changelog
All notable changes to this project will be documented in this file.

---
## [3.2.0] - 2026-09-16

### Added
- Builder pattern for Driver configuration. This is the new recommended way to configure the driver. 
  The previous approach is now deprecated and will be removed in a future release.

```ruby
builder = DVLA::Browser::Drivers.cuprite_builder

builder.headed.disable_javascript.register!
```

- Deprecation warning to meta_driver methods.

---
## [3.1.2] - 2026-01-19

- Remove dvla-herodotus dependency

---
## [3.1.1] - 2025-12-12

- Add selenium_safari config
- Add optional binary string for Selenium 

---
## [3.1.0] - 2025-12-10

- Add websocket URL to enable BiDi functionality via Selenium
- Added a changelog
