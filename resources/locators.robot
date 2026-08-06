*** Variables ***

# ---------------- LOGIN ----------------

${USERNAME_INPUT}      id:user-name
${PASSWORD_INPUT}      id:password
${LOGIN_BUTTON}        id:login-button
${ERROR_MESSAGE}       xpath=//h3[@data-test='error']

# ---------------- INVENTORY ----------------

${PRODUCT_TITLE}       css:.title
${BACKPACK}            xpath=//div[text()="Sauce Labs Backpack"]
${ADD_BACKPACK}        id:add-to-cart-sauce-labs-backpack
${REMOVE_BACKPACK}     id:remove-sauce-labs-backpack

# ---------------- CART ----------------

${SHOPPING_CART}       css:.shopping_cart_link
${CART_BADGE}          css:.shopping_cart_badge
${CART_ITEM}           css:.cart_item
${CHECKOUT_BUTTON}     id:checkout

# ---------------- CHECKOUT ----------------

${FIRST_NAME}          id:first-name
${LAST_NAME}           id:last-name
${ZIP_CODE}            id:postal-code
${CONTINUE_BUTTON}     id:continue
${FINISH_BUTTON}       id:finish

# ---------------- COMPLETE ----------------

${SUCCESS_MESSAGE}     css:.complete-header