

// Product Quantity
$('.btn-minus, .btn-plus').on('click', function () {
    let change = 0;

    var button = $(this);
    var oldValue = button.parent().parent().find('input').val();
    if (button.hasClass('btn-plus')) {
        var newVal = parseFloat(oldValue) + 1;
        change = 1
    } else {
        if (oldValue > 1) {
            var newVal = parseFloat(oldValue) - 1;
            change = -1;
        } else {
            newVal = 1;
            //alert("Min");
        }
    }
    const input = button.parent().parent().find('input');
    input.val(newVal);

    //set form index
    const index = input.attr("data-cart-detail-index");
    const element = document.getElementById(`cartDetails${index}.quantity`);
    $(element).val(newVal);

    //get price
    const price = input.attr("data-cart-detail-price");
    const id = input.attr("data-cart-detail-id");

    const priceElement = $(`td[data-cart-detail-id='${id}']`);
    if (priceElement) {
        const newPrice = +price * newVal;
        priceElement.text(formatCurrency(newPrice.toFixed(2)) + " đ");
    }

    //update total cart price
    const totalPriceElement = $(`[data-cart-total-price]`);

    if (totalPriceElement && totalPriceElement.length) {
        const currentTotal = totalPriceElement.first().attr("data-cart-total-price");
        let newTotal = +currentTotal;
        if (change === 0) {
            newTotal = +currentTotal;
        } else {
            newTotal = change * (+price) + (+currentTotal);
        }

        //reset change
        change = 0;

        //update
        totalPriceElement?.each(function (index, element) {
            //update text
            $(totalPriceElement[index]).text(formatCurrency(newTotal.toFixed(2)) + " đ");

            //update data-attribute
            $(totalPriceElement[index]).attr("data-cart-total-price", newTotal);
        });
    }
});

function formatCurrency(value) {
    // Use the 'vi-VN' locale to format the number according to Vietnamese currency format
    // and 'VND' as the currency type for Vietnamese đồng
    const formatter = new Intl.NumberFormat('vi-VN', {
        style: 'decimal',
        minimumFractionDigits: 0, // No decimal part for whole numbers
    });

    let formatted = formatter.format(value);
    // Replace dots with commas for thousands separator
    formatted = formatted.replace(/\./g, '.');
    return formatted;
}


