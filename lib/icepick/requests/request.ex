defmodule Icepick.Request do

  defstruct ad_size: nil, country: nil

  def fromJson(json) do
    %Icepick.Request{
      country: get_in(json, ["device", "geo", "country"])
    }
  end


end