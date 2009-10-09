# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{erubis_rails_helper}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dave Elkins"]
  s.date = %q{2009-10-09}
  s.description = %q{Drop in replacement for the Rails integration in the Erubis gem so that Erubis will work with Rails 2.3.}
  s.email = %q{dave@elkinsware.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "lib/erubis_rails_helper.rb",
     "lib/erubis_rails_helper/erubis/generator.rb",
     "lib/erubis_rails_helper/template_handlers/erubis.rb"
  ]
  s.homepage = %q{http://github.com/elkinsware/erubis_rails_helper/tree/master}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Drop in replacement for the Rails integration in the Erubis gem so that Erubis will work with Rails 2.3.}
  s.test_files = [
    "test/abstract_unit.rb",
     "test/controller/action_pack_assertions_test.rb",
     "test/controller/addresses_render_test.rb",
     "test/controller/assert_select_test.rb",
     "test/controller/base_test.rb",
     "test/controller/benchmark_test.rb",
     "test/controller/caching_test.rb",
     "test/controller/capture_test.rb",
     "test/controller/content_type_test.rb",
     "test/controller/controller_fixtures/app/controllers/admin/user_controller.rb",
     "test/controller/controller_fixtures/app/controllers/user_controller.rb",
     "test/controller/controller_fixtures/vendor/plugins/bad_plugin/lib/plugin_controller.rb",
     "test/controller/cookie_test.rb",
     "test/controller/deprecation/deprecated_base_methods_test.rb",
     "test/controller/dispatcher_test.rb",
     "test/controller/fake_controllers.rb",
     "test/controller/fake_models.rb",
     "test/controller/filters_test.rb",
     "test/controller/filter_params_test.rb",
     "test/controller/flash_test.rb",
     "test/controller/header_test.rb",
     "test/controller/helper_test.rb",
     "test/controller/html-scanner/cdata_node_test.rb",
     "test/controller/html-scanner/document_test.rb",
     "test/controller/html-scanner/node_test.rb",
     "test/controller/html-scanner/sanitizer_test.rb",
     "test/controller/html-scanner/tag_node_test.rb",
     "test/controller/html-scanner/text_node_test.rb",
     "test/controller/html-scanner/tokenizer_test.rb",
     "test/controller/http_basic_authentication_test.rb",
     "test/controller/http_digest_authentication_test.rb",
     "test/controller/integration_test.rb",
     "test/controller/layout_test.rb",
     "test/controller/logging_test.rb",
     "test/controller/middleware_stack_test.rb",
     "test/controller/mime_responds_test.rb",
     "test/controller/mime_type_test.rb",
     "test/controller/polymorphic_routes_test.rb",
     "test/controller/rack_test.rb",
     "test/controller/record_identifier_test.rb",
     "test/controller/redirect_test.rb",
     "test/controller/render_test.rb",
     "test/controller/request/json_params_parsing_test.rb",
     "test/controller/request/multipart_params_parsing_test.rb",
     "test/controller/request/query_string_parsing_test.rb",
     "test/controller/request/url_encoded_params_parsing_test.rb",
     "test/controller/request/xml_params_parsing_test.rb",
     "test/controller/request_forgery_protection_test.rb",
     "test/controller/request_test.rb",
     "test/controller/rescue_test.rb",
     "test/controller/resources_test.rb",
     "test/controller/routing_test.rb",
     "test/controller/selector_test.rb",
     "test/controller/send_file_test.rb",
     "test/controller/session/cookie_store_test.rb",
     "test/controller/session/mem_cache_store_test.rb",
     "test/controller/session/test_session_test.rb",
     "test/controller/test_test.rb",
     "test/controller/translation_test.rb",
     "test/controller/url_rewriter_test.rb",
     "test/controller/verification_test.rb",
     "test/controller/view_paths_test.rb",
     "test/controller/webservice_test.rb",
     "test/fixtures/alternate_helpers/foo_helper.rb",
     "test/fixtures/company.rb",
     "test/fixtures/developer.rb",
     "test/fixtures/helpers/abc_helper.rb",
     "test/fixtures/helpers/fun/games_helper.rb",
     "test/fixtures/helpers/fun/pdf_helper.rb",
     "test/fixtures/mascot.rb",
     "test/fixtures/project.rb",
     "test/fixtures/reply.rb",
     "test/fixtures/topic.rb",
     "test/template/asset_tag_helper_test.rb",
     "test/template/atom_feed_helper_test.rb",
     "test/template/benchmark_helper_test.rb",
     "test/template/compiled_templates_test.rb",
     "test/template/date_helper_i18n_test.rb",
     "test/template/date_helper_test.rb",
     "test/template/erb_util_test.rb",
     "test/template/form_helper_test.rb",
     "test/template/form_options_helper_test.rb",
     "test/template/form_tag_helper_test.rb",
     "test/template/javascript_helper_test.rb",
     "test/template/number_helper_i18n_test.rb",
     "test/template/number_helper_test.rb",
     "test/template/prototype_helper_test.rb",
     "test/template/record_tag_helper_test.rb",
     "test/template/render_test.rb",
     "test/template/sanitize_helper_test.rb",
     "test/template/scriptaculous_helper_test.rb",
     "test/template/tag_helper_test.rb",
     "test/template/test_test.rb",
     "test/template/text_helper_test.rb",
     "test/template/translation_helper_test.rb",
     "test/template/url_helper_test.rb",
     "test/testing_sandbox.rb",
     "test/test_erubis_rails_helper.rb",
     "test/view/test_case_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, [">= 2.2.2"])
      s.add_runtime_dependency(%q<erubis>, [">= 2.6.2"])
    else
      s.add_dependency(%q<actionpack>, [">= 2.2.2"])
      s.add_dependency(%q<erubis>, [">= 2.6.2"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 2.2.2"])
    s.add_dependency(%q<erubis>, [">= 2.6.2"])
  end
end
