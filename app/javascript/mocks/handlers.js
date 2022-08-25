import { rest } from 'msw'
import { fakeMetrics } from '../services/db'

export const handlers = [
    rest.get(`/api/v1/metrics.json`, (req, res, ctx) => {
        return res(ctx.status(200), ctx.json(fakeMetrics));
    }),

    rest.post(`/api/v1/metrics.json`, async (req, res, ctx) => {
        const body = await req.json();
        fakeMetrics.data = [
            ...fakeMetrics.data,
            {
                id: fakeMetrics.data.length.toString(),
                type: 'metric',
                attributes: {
                    name: body.name,
                    key: body.key,
                    value: body.value,
                    timestamp: body.timestamp
                }
            }
        ];
        return res(ctx.status(200), ctx.json(fakeMetrics));
    })
];
