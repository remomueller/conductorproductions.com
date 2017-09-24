# frozen_string_literal: true

# Provides general application helper methods for HAML views.
module ApplicationHelper
  def simple_check(checked)
    content_tag(:i, "", class: "fa #{checked ? "fa-check-square-o" : "fa-square-o"}")
  end
end
