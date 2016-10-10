# frozen_string_literal: true

namespace :documents do
  desc 'Update documents to use new primary document'
  task add_primary_document: :environment do
    Document.where(primary_document: nil).where.not(document: nil).find_each do |document|
      if document.document_identifier.last(4).to_s.downcase == '.pdf'
        puts "Document Updated: #{document.document_identifier}"
        document.update(primary_document: document.document, remove_document: '1')
      end
    end
  end
end
