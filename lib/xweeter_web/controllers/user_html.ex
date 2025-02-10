defmodule XweeterWeb.UserHTML do
  use XweeterWeb, :html

  # def index(assigns) do
  #   ~H"""
  #     Hey mother fucker
  #   """
  # end

  # OR

  embed_templates "user_html/*" #embed all .heex templat found in the sibling user_html directory
end
