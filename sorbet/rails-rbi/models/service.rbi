# This is an autogenerated file for dynamic methods in Service
# Please rerun rake rails_rbi:models to regenerate.
# typed: strong

class Service::ActiveRecord_Relation < ActiveRecord::Relation
  include Service::ModelRelationShared
  extend T::Generic
  Elem = type_member(fixed: Service)
end

class Service::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include Service::ModelRelationShared
  extend T::Generic
  Elem = type_member(fixed: Service)
end

class Service < ActiveRecord::Base
  extend T::Sig
  extend T::Generic
  extend Service::ModelRelationShared
  include Service::InstanceMethods
  Elem = type_template(fixed: Service)
end

module Service::InstanceMethods
  extend T::Sig

  sig { returns(T.untyped) }
  def created_at(); end

  sig { params(value: T.untyped).void }
  def created_at=(value); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def created_at?(*args); end

  sig { returns(T.nilable(T.untyped)) }
  def deleted_at(); end

  sig { params(value: T.nilable(T.untyped)).void }
  def deleted_at=(value); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def deleted_at?(*args); end

  sig { returns(Integer) }
  def id(); end

  sig { params(value: Integer).void }
  def id=(value); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def id?(*args); end

  sig { returns(T.nilable(String)) }
  def name(); end

  sig { params(value: T.nilable(String)).void }
  def name=(value); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def name?(*args); end

  sig { returns(T.nilable(Integer)) }
  def parent_id(); end

  sig { params(value: T.nilable(Integer)).void }
  def parent_id=(value); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def parent_id?(*args); end

  sig { returns(T.untyped) }
  def updated_at(); end

  sig { params(value: T.untyped).void }
  def updated_at=(value); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def updated_at?(*args); end

  sig { returns(T.nilable(T.untyped)) }
  def uuid(); end

  sig { params(value: T.nilable(T.untyped)).void }
  def uuid=(value); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def uuid?(*args); end

end

class Service
  extend T::Sig

  sig { returns(::Service::ActiveRecord_Associations_CollectionProxy) }
  def children(); end

  sig { params(value: T.any(T::Array[::Service], ::Service::ActiveRecord_Associations_CollectionProxy)).void }
  def children=(value); end

  sig { returns(T.nilable(::GlobalService)) }
  def global_service(); end

  sig { params(value: T.nilable(::GlobalService)).void }
  def global_service=(value); end

  sig { returns(T.nilable(::Service)) }
  def parent(); end

  sig { params(value: T.nilable(::Service)).void }
  def parent=(value); end

  sig { returns(::ProgramStreamService::ActiveRecord_Associations_CollectionProxy) }
  def program_stream_services(); end

  sig { params(value: T.any(T::Array[::ProgramStreamService], ::ProgramStreamService::ActiveRecord_Associations_CollectionProxy)).void }
  def program_stream_services=(value); end

  sig { returns(::ProgramStream::ActiveRecord_Associations_CollectionProxy) }
  def program_streams(); end

  sig { params(value: T.any(T::Array[::ProgramStream], ::ProgramStream::ActiveRecord_Associations_CollectionProxy)).void }
  def program_streams=(value); end

  sig { returns(::Referral::ActiveRecord_Associations_CollectionProxy) }
  def referrals(); end

  sig { params(value: T.any(T::Array[::Referral], ::Referral::ActiveRecord_Associations_CollectionProxy)).void }
  def referrals=(value); end

end

module Service::ModelRelationShared
  extend T::Sig

  sig { returns(Service::ActiveRecord_Relation) }
  def all(); end

  sig { params(block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped).returns(Service::ActiveRecord_Relation) }
  def deleted_after_time(*args); end

  sig { params(args: T.untyped).returns(Service::ActiveRecord_Relation) }
  def deleted_before_time(*args); end

  sig { params(args: T.untyped).returns(Service::ActiveRecord_Relation) }
  def deleted_inside_time_window(*args); end

  sig { params(args: T.untyped).returns(Service::ActiveRecord_Relation) }
  def names(*args); end

  sig { params(args: T.untyped).returns(Service::ActiveRecord_Relation) }
  def only_children(*args); end

  sig { params(args: T.untyped).returns(Service::ActiveRecord_Relation) }
  def only_parents(*args); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def select(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def order(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def reorder(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def group(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def limit(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def offset(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def joins(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def where(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def rewhere(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def preload(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def eager_load(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def includes(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def from(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def lock(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def readonly(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def or(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def having(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def create_with(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def distinct(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def references(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def none(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def unscope(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(Service::ActiveRecord_Relation) }
  def except(*args, &block); end

end