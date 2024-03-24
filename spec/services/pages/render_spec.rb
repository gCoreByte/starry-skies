# frozen_string_literal: true

RSpec.describe Pages::Render do
  let(:store) { create(:store) }
  let(:page) { create(:page, store: store, record: record, page_template: page_template) }
  let(:content) do
    'Hello {{ store.name }}! Welcome to {{ store.name }}. We have {{ product.key }} in stock.'
  end
  let(:page_template) { create(:page_template, content: content, store: store, based_on: record.class.name.downcase) }

  subject { described_class.new(page: page, record: record) }

  describe '#render' do
    context 'when page is dynamic' do
      let(:page) { create(:page, :dynamic, store: store, record: other_record, page_template: page_template) }
      let!(:record) { create(:product, store: store) }
      let!(:other_record) { create(:product, store: store) }

      it do
        expect(subject.render).to eq("Hello #{store.name}! Welcome to #{store.name}. We have #{record.key} in stock.")
      end
    end

    context 'when page is not dynamic' do
      let!(:record) { create(:product, store: store) }

      it do
        expect(subject.render).to eq("Hello #{store.name}! Welcome to #{store.name}. We have #{record.key} in stock.")
      end
    end

    context 'when page_template is based on store' do
      let(:page_template) { create(:page_template, content: content, based_on: 'store') }
      let(:content) { 'Hello {{ store.name }}! Welcome to {{ store.name }}.' }
      let!(:record) { store }

      it do
        expect(subject.render).to eq("Hello #{store.name}! Welcome to #{store.name}.")
      end

      context 'when store is provided by record' do
        let!(:record) { create(:product, store: store) }

        it do
          expect(subject.render).to eq("Hello #{store.name}! Welcome to #{store.name}.")
        end
      end
    end
  end
end
