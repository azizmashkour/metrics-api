import React from 'react'
import { shallow } from 'enzyme'

import Button from './Button'

it("Should render Button", () => {
  const wrapper = shallow(<Button />);
  expect(wrapper.find("button")).toBeTruthy();
});
