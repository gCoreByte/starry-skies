# frozen_string_literal: true

RSpec.describe Pages::Render do
  let(:store) { create(:store) }
  let(:page) { create(:page, store: store, page_template: page_template) }
  let(:content) do
    'Hello {{ store.name }}! Welcome to {{ store.name }}. We have {{ product.key }} in stock.'
  end
  let(:page_template) { create(:page_template, store: store, based_on: record.class.name.downcase) }
  let!(:page_translation) { create(:page_translation, content: content, store: store, page_template: page_template) }

  subject { described_class.new(page: page, record: record) }

  describe '#render' do
    context 'when page_template is based on store' do
      let(:page_template) { create(:page_template, based_on: 'store') }
      let(:content) { 'Hello {{ store.name }}! Welcome to {{ store.name }}.' }
      let!(:record) { store }

      it do
        expect(subject.render).to eq("Hello #{store.name}! Welcome to #{store.name}.")
      end
    end
  end
end
