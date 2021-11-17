class AdminInvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.update(status: params[:status])
    redirect_to "/admin/invoices/#{invoice.id}"
  end
end
