ifeq (,$(filter $(PHP_NAME_VERSION),5.5 5.6))
ext_PACKAGES     += json
json_DESCRIPTION := JSON
json_EXTENSIONS  := json
json_config      := --enable-json=shared
export json_EXTENSIONS
export json_DESCRIPTION
endif
