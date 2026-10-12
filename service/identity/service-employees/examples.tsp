import "./models.tsp";

namespace IdentityService.ServiceEmployees;

const GetAccountByPhoneServiceExample = #{
  parameters: #{
    body: #{
      countryCode: "+7",
      phoneNumber: "9992394123",
    },
  },
  returnType: #{
    statusCode: 200,
    body: #{
      id: "60a927a8-5b73-48b8-a2c8-1cd33ecfb333",
      firstName: "Иван",
      lastName: "Иванов",
      patronymic: "Иванович",
      email: "ivan.ivanov@example.com",
      files: #[
        #{
          key: "accounts/60a927a8-5b73-48b8-a2c8-1cd33ecfb333/avatar.png",
          name: "avatar.png",
          parentId: "60a927a8-5b73-48b8-a2c8-1cd33ecfb333",
          size: 6570,
          contentType: "image/png",
          lastModified: utcDateTime.fromISO("2026-09-08T12:00:00Z"),
          url: "/accounts/60a927a8-5b73-48b8-a2c8-1cd33ecfb333/avatar.png",
          priority: 0,
          fileType: Files.FileType.Img,
          resourceId: "fe1158fa-5c1d-4356-a0e7-2f173f7cad02",
          parentType: "Account",
          bucketName: "accounts",
        },
      ],
    },
  },
};

const ServiceEmployeeExample = #{
  employeeId: "a6c2f50e-9ca7-408c-8dd3-953fdd48fff2",
  accountId: "60a927a8-5b73-48b8-a2c8-1cd33ecfb333",
  firstName: "Иван",
  lastName: "Иванов",
  patronymic: "Иванович",
  countryCode: "+7",
  phoneNumber: "9992394123",
  email: "ivan.ivanov@example.com",
  serviceRoleId: "56bc7cf1-3b50-4785-ac56-b4fe8bd84c0c",
  partnerZoneIds: #["c509f9a8-26f4-4254-b2c8-04d6f1bcbfe1"],
  hasAccessToAllPartnerZones: false,
  isArchived: false,
  files: #[
    #{
      key: "accounts/60a927a8-5b73-48b8-a2c8-1cd33ecfb333/avatar.png",
      name: "avatar.png",
      parentId: "60a927a8-5b73-48b8-a2c8-1cd33ecfb333",
      size: 6570,
      contentType: "image/png",
      lastModified: utcDateTime.fromISO("2026-09-08T12:00:00Z"),
      url: "/accounts/60a927a8-5b73-48b8-a2c8-1cd33ecfb333/avatar.png",
      priority: 0,
      fileType: Files.FileType.Img,
      resourceId: "fe1158fa-5c1d-4356-a0e7-2f173f7cad02",
      parentType: "Account",
      bucketName: "accounts",
    },
  ],
};

const ServiceEmployeeResponseExample = #{
  returnType: #{
    statusCode: 200,
    body: ServiceEmployeeExample,
  },
};

const GetAllServiceEmployeesExample = #{
  parameters: #{
    body: #{ partnerZoneIds: #[] },
  },
  returnType: #{
    statusCode: 200,
    body: #{ employees: #[ServiceEmployeeExample] },
  },
};

const GetServiceEmployeesByPartnerZoneIdsExample = #{
  parameters: #{
    body: #{ partnerZoneIds: #["c509f9a8-26f4-4254-b2c8-04d6f1bcbfe1"] },
  },
  returnType: #{
    statusCode: 200,
    body: #{ employees: #[ServiceEmployeeExample] },
  },
};
