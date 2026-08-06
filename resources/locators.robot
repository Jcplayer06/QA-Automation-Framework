*** Variables ***

# Login Page
${USERNAME_INPUT}      id:user-name
${PASSWORD_INPUT}      id:password
${LOGIN_BUTTON}        id:login-button
${ERROR_MESSAGE}    css:[data-test="error"]

# Inventory Page
${PRODUCT_TITLE}       css:.title
${ADD_BACKPACK}        id:add-to-cart-sauce-labs-backpack
${CART_BADGE}          css:.shopping_cart_badge
${SHOPPING_CART}       css:.shopping_cart_link

# Checkout
${CHECKOUT_BUTTON}     id:checkout
${FIRST_NAME}          id:first-name
${LAST_NAME}           id:last-name
${ZIP_CODE}            id:postal-code
${CONTINUE_BUTTON}     id:continue
${FINISH_BUTTON}       id:finish
${SUCCESS_MESSAGE}     css:.complete-header

# Cart
${CART_ITEM}           css:.cart_item
${CHECKOUT_BUTTON}     id:checkout

# Checkout Information
${FIRST_NAME}          id:first-name
${LAST_NAME}           id:last-name
${ZIP_CODE}            id:postal-code
${CONTINUE_BUTTON}     id:continue

# Checkout Overview
${FINISH_BUTTON}       id:finish

# Success
${SUCCESS_MESSAGE}     css:.complete-header

