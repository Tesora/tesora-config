# == Class: tesora_cyclone::users
#
class tesora_cyclone::users {
  @user::virtual::localuser { 'andrew':
    realname => 'Andrew Bramley',
    sshkeys  => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2hUSOxfEEp8OiFoudNcSUgU8D0J+sEipQAHAzXn5VHkECyOkrfXwr2fIodIztmhNyimc0VVzKLJcY4f6HMBLMtgP5XVacN7QCHvemibNLcK0cmAzkQHDT105h6fpnYdT10Mn9g2yrubHcAd7+lF3owuQUNkE5CCSt/0/e2XlCLrreISzY/LzoMCjpeeWLtCFAaYaqfMNRURr4j0qE2rfcz1u/oU2Aa7xgoePegW/wtVCWpaOl0jGvo5Pkgn+bBOercxZKT92zIsfbthA4eHUjg9AhWRMipoVSvYn0iRpfoFPAHONImZu45SqCeu/+82FZXrDpOdLph9lqSRZhwb+N abramley@Bram-Mac.local',
    key_id   => 'andrew@tesora.com',
  }

  @user::virtual::localuser { 'amrith':
    realname => 'Amrith Kumar',
    sshkeys  => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCmo4+INq4ocvY0yna3jd5jmqxBxLU8eF+V/dYPC7L4Ceu3TNEBIl/gKUNGJApmEH82+Luos0g6ViqA4DyCC2b90Daiagp3HEGIPZ13yNDLcxoFoXH8nSYpQMxmNfjbgOO3lSbz4ti+fBGeJW+jixfEqGOQwkijJo57vkvjohft2K0vvFqCK4iLrQazS1sr1Jtu+ULInSz9mt25Y1HMl0Xv/8C9hi4xStzxfi7290lnBFL+hm+YDfVS4dWvrk4VMcLT2CXom7Xq53Ft88+XPfSJPs6bZ4pW4BIeEPRKCqt1FKDoQrsjeE5DhAEDT4Ro4C3hT2dT51HwjL7+RGXXMdUr ftp.parelastic.com - User: amrith',
    key_id   => 'amrith@tesora.com',
  }

  @user::virtual::localuser { 'bhunter':
    realname => 'Brian Hunter',
    sshkeys  => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC03xWgnO2+v4EDn8jajgkUg4+X8iDOvD9c62h8qxqKNY35sefrtFkbUdPWxj1i6zW+X7+dDOuAM5ZtVhmVc0X+t6J6b4igZy1gmtdm4ca560SBa0kVs2tBGLLXmCOoSEA9N/32/LgPq5ggmAehyDkKaZxTUxmIvkZnaxynv8XUrBmfapTupLZ/3E24ysj/1ood4/buIOe9gpei6r1iMGkT2CNcW9SRg54N0NDG40y+R1BDMLdQSqiUf6Ov7A+U5clDtB5piqPKt4Wj2ckXPWFcKQ0TAvY+tX9u/M2dzUwq6Sqd4LqKcG2Tk3hxP/bC3KZz3XLkf5mpAFdawCWfxSLf bhunter@tesora.com',
    key_id   => 'bhunter@tesora.com',
  }

  @user::virtual::localuser { 'doug':
    realname => 'Doug Shelley',
    sshkeys  => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDC4HL4EsY0QB/b4ATDPpAbvWIq6iP/YNWRwlEgOrZeE2nJ0K27RrLZDE0diyySyRE2bFeIy3ILX21aycNR7mYRmLMJb6nMZ7RUz2J76Xp2FayuPuXCoESxXQO0aL/3yUVNPYHkF3Ux3q2FWxPF1OAN1kJMBWGmY/XlFYskR6DMp650H8Wz056tPdgrlnanY0nAoEKD793wAsQ1x0wpzqd1tq4A/bvqLKEy6wcvc+WnXmPYkyL7y9tDY7Tk61Il4lusHKJ/Xjn2PxZr/pyySqfBtrr3gmB45zuv238G/kyCDh3/MH4IPpihKi0iXclba9CcjqBr43HG+keui9+birMZ vbox@dougvm1',
    key_id   => 'doug@tesora.com',
  }


}
