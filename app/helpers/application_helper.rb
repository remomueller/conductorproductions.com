# frozen_string_literal: true

# Provides general application helper methods for HAML views.
module ApplicationHelper
  def simple_check(checked)
    if checked
      content_tag :span, nil, class: %w(glyphicon glyphicon-ok)
    else
      ''
    end
  end
end
