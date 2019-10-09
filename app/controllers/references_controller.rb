class ReferencesController < ApplicationController
  expose(:references) { Reference.scoped }
  expose(:reference)

  expose(:ref_list) { Scope.new(Reference.scoped, page: params[:p]) }
  expose(:shelf) { Shelf.find(params[:s]) if params[:s].present? }
  expose(:current_library) { reference.library }
  expose(:layout_row) { nil }

  autocomplete :reference, :title

  caches_page :index, :show

  def index
    index!(Reference)
  end

  def show
    if params[:shelf_id].present?
      redirect_to reference
    else
      show!(reference)
    end
  end

  def new
    if params[:s].blank?
      redirect_to root_path, alert: 'Todas las referencias deben ir en alguna lista'
    else
      new!(reference)
    end
  end

  def edit
    edit!(reference)
  end

  %i[tag publish coverize].each do |action|
    define_method action do
      edit!(reference)
    end
  end

  def create
    if found = Reference.find_by_title(reference.title)
      add_reference_to_shelf(found, shelf)
      redirect_to view_shelf_path(shelf)
    else
      quick = reference.ref_type.blank?
      reference.library = shelf.library
      reference.user = current_user
      reference.ref_type ||= 'Book'
      reference.license ||= License.first
      create!(reference, :reference) do
        add_reference_to_shelf(reference, shelf)
        quick ? edit_reference_path(reference) : reference_path(reference)
      end
    end
  end

  def update
    update!(reference, :reference) do
      Notifier.perform_async(:reference, :update, reference.id)
      reference_path(reference)
    end
  end

  def destroy
    destroy!(reference, :reference) { root_path }
  end

  def get_autocomplete_items(parameters)
    term = parameters[:term]
    Reference.select('id, title')
             .where('(LOWER(title) ILIKE ?)', "%#{term}%")
             .limit(10)
  end

  protected

  def add_reference_to_shelf(reference, shelf)
    item = shelf.add_reference(reference, current_user)
    Notifier.perform_async(:shelf_item, :create, item.id)
    UpdateShelfMetadata.perform_async(shelf.id)
  end
end
