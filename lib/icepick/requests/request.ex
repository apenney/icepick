defmodule Request do

  defstruct ad_size: nil, country: nil

  def fromJson(json) do
    %Request{
      country: get_in(json, "")
    }
  end


end