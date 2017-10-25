# frozen_string_literal: true

module Conductor
  module VERSION #:nodoc:
    MAJOR = 10
    MINOR = 0
    TINY = 0
    BUILD = "beta1" # "pre", "beta1", "beta2", "rc", "rc2", nil

    STRING = [MAJOR, MINOR, TINY, BUILD].compact.join(".")
  end
end
