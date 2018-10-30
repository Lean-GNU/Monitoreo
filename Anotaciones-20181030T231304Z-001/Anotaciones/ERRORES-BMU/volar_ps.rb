scope = PendingSync.unacked
scope.distinct.pluck(:model_id).each do |model_id|
 model_scope = scope.where(model_id: model_id)
 actions = model_scope.distinct.pluck(:action)

 next if model_scope.count == 1

 case
 when actions.include?('create') && actions.include?('destroy')
   model_scope.delete_all

 when actions.include?('destroy')
   model_scope.where(action: :update).delete_all

 when actions.include?('update')
   exclude_id = model_scope.where(action: :update).last.id
   model_scope.where(action: :update).where.not(id: exclude_id).delete_all
 end
end
