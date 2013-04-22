module RedmineSidekiq
  class AdminConstraint
    def matches?(request)
      User.current.admin
    end
  end
end