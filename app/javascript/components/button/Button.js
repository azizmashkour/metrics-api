import React, { Fragment } from 'react'
import PropTypes from 'prop-types'

const Button = props => {
  return (
    <button
      disabled={props.disabled}
      type={props.type ? props.type : 'button'}
      onClick={() => props.onClick?.()}
      className='bg-sky-500 text-white active:bg-purple-600 font-bold uppercase text-sm px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mb-1 mt-3 ease-linear transition-all duration-150 disabled:bg-gray-400'>
      {props.children}
    </button>
  )
}

Button.defaultProps = {
  disabled: false
}

Button.propTypes = {
  disabled: PropTypes.bool,
  onClick: PropTypes.func,
  type: PropTypes.oneOf(['button', 'submit', 'reset'])
}

export default Button
