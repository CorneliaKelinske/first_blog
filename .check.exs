[
  ## don't run tools concurrently
  # parallel: false,

  ## don't print info about skipped tools
  # skipped: false,

  ## always run tools in fix mode (put it in ~/.check.exs locally, not in project config)
  fix: true,

  ## don't retry automatically even if last run resulted in failures
  retry: false,

  ## list of tools (see `mix check` docs for a list of default curated tools)
  tools: [
    {:npm_test, false},
    {:ex_coveralls_html,
     command: "mix coveralls.html",
     require_files: ["test/test_helper.exs"],
     env: %{"MIX_ENV" => "test"}},
    {:ex_coveralls_lcov,
     command: "mix coveralls.lcov",
     require_files: ["test/test_helper.exs"],
     env: %{"MIX_ENV" => "test"}},
    {:credo, command: "mix credo --strict"}
  ]
]
