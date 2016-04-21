defmodule Icepick.Rule do

  defstruct ad_size: nil, country: nil

  defmodule RuleCondition do
    defstruct type: :include_only, features: []
  end

end