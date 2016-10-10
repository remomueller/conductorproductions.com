# frozen_string_literal: true

namespace :documents do
  desc 'Update documents to use new primary document'
  task add_primary_document: :environment do
    Document.where(primary_document: nil).where.not(document: nil).find_each do |document|
      if ['.pdf', '.png'].include?(document.document_identifier.last(4).to_s.downcase)
        puts "Primary Document Updated: #{document.document_identifier}"
        document.update(primary_document: document.document, remove_document: '1')
      end
    end
    Document.where(primary_document: nil).where.not(document: nil).find_each do |document|
      if document.document_identifier.last(5).to_s.downcase == '.docx'
        name = document.document_identifier.gsub(/\.docx$/, '.pdf')
        pdoc = document.project.documents.where(document: nil).find_by(primary_document: name)
        if pdoc
          puts "Attaching #{document.document_identifier} to #{pdoc.primary_document_identifier}"
          pdoc.update document: document.document
          document.destroy
        else
          puts "Skipping #{document.document_identifier}"
        end
      end
    end
  end
end
