  class ReferenceChecklist < Checklist
    def initialize(reference, view)
      super(view)

      needs :description, if: reference.description.blank?
      needs :tags, if: reference.tag_names.blank?
      needs :download, if: (reference.downloads_count == 0),
        visible: reference.libre?
    end
  end
