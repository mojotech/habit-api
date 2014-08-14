class UpdateOldTargets < ActiveRecord::Migration
  def change
    Target.all.each { |t| t.update_completion }
  end
end
